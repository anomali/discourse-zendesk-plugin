class ::ZendeskController < ::ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'
  require 'base64'

  def create_ticket
    return render nothing: true unless current_user && current_user.staff?

    request_url = SiteSetting.zendesk_base_url + "/api/v2/tickets.json"
    uri = URI.parse(request_url)
    auth = 'Basic '+ Base64.encode64( SiteSetting.zendesk_email + ":" + SiteSetting.zendesk_password ).chomp
    header = {'Content-Type': 'application/json', 'Authorization': auth}
    data = {
      "ticket": {
        "subject":  params[:topic_title],
        "comment":  { "body": params[:html_comment] },
        "external_id": params[:external_id]
      }
    }

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json

    # Send the request
    response = http.request(request)

    response_json = JSON.parse(response.body)
    ticket = response_json["ticket"]
    if response.kind_of? Net::HTTPSuccess
      return render json: { url: SiteSetting.zendesk_base_url + "/agent/tickets/#{ticket["id"]}",
                            text: "View #{ticket["status"].titleize} Zendesk Ticket",
                            title: title(ticket["status"]),
                            css_class: ticket["status"],
                            exists: true }
    else
      return render json: { text: 'Create Zendesk Ticket',
                     title: 'Click to create a new Ticket in Zendesk',
                     exists: false }
    end

  end

  def find_ticket
    return render nothing: true unless current_user && current_user.staff?


    if session[:zendesk_user_id].nil?
      get_user(SiteSetting.zendesk_email)
    end
    request_url = SiteSetting.zendesk_base_url + "/api/v2/users/" + session[:zendesk_user_id] + "/tickets/requested.json"
    
    uri = URI.parse(request_url)
    auth = 'Basic '+ Base64.encode64( SiteSetting.zendesk_email + ":" + SiteSetting.zendesk_password ).chomp
    header = {'Authorization': auth}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)

    response_json = JSON.parse(response.body)
    if response_json["tickets"].any?
      for ticket in response_json["tickets"]
        if ticket["external_id"] == params[:external_id]
          return render json: { url: SiteSetting.zendesk_base_url + "/agent/tickets/#{ticket["id"]}",
                         text: "View #{ticket["status"].titleize} Zendesk Ticket",
                         title: title(ticket["status"]),
                         css_class: ticket["status"],
                         exists: true }
        end
      end
    else
      return render json: { text: 'Create Zendesk Ticket',
                     title: 'Click to create a new Ticket in Zendesk',
                     exists: false }
    end

  end

  def list_tickets

    if session[:zendesk_user_id].nil?
      get_user(SiteSetting.zendesk_email)
    end

    request_url = SiteSetting.zendesk_base_url + "/api/v2/users/" + session[:zendesk_user_id] + "/tickets/requested.json"
    uri = URI.parse(request_url)
    auth = 'Basic '+ Base64.encode64( SiteSetting.zendesk_email + ":" + SiteSetting.zendesk_password ).chomp
    header = {'Authorization': auth}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)
    response_json = JSON.parse(response.body)

    return render json: response_json
  end

  def title(status)
    case status
      when "new"      then "Ticket is New. "
      when "open"     then "Ticket is Open. "
      when "pending"  then "Ticket is Pending. "
      when "solved"   then "Ticket has been Solved. "
      when "closed"   then "Ticket has been Closed. "
      when "hold"     then "Ticket is on Hold. "
      else "Ticket status is unknown. "
    end + "Click to view in Zendesk"
  end

  def get_user(email)
    request_url = SiteSetting.zendesk_base_url + "/api/v2/users.json?role[]=agent"
    uri = URI.parse(request_url)
    auth = 'Basic '+ Base64.encode64( SiteSetting.zendesk_email + ":" + SiteSetting.zendesk_password ).chomp
    header = {'Authorization': auth}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)
    response_json = JSON.parse(response.body)
    if response_json["users"].any?
      for user in response_json["users"]
        if user["email"] == email
          session[:zendesk_user_id] = user["id"].to_s
        end
      end
    else
      return nil
    end

  end

end
