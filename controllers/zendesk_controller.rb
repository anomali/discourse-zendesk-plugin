class ::ZendeskController < ::ApplicationController
  require 'zendesk_api'
  require 'net/http'
  require 'json'
  require 'uri'
  require 'base64'

  def create_ticket
    return render nothing: true unless current_user && current_user.staff?
    the_ticket = NewZendeskTicket.new(
      ticket_data: {
        external_id: params[:external_id],
        subject: params[:topic_title],
        requester: params[:requester],
        collaborators: [params[:collaborator_email]]
      },
      post_url: params[:post_url],
      html_comment: params[:html_comment]
    )


    uri = URI.parse("https://anomali.zendesk.com/api/v2/tickets.json")
    auth = 'Basic '+ Base64.encode64( 'zendesksupport@anomali.com:R4gwxTBvYCm8Fd!' ).chomp
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

    render_ticket_json(the_ticket)
  end

  def find_ticket
    return render nothing: true unless current_user && current_user.staff?
    the_ticket = ExistingZendeskTicket.new(params[:external_id])

    uri = URI.parse("https://anomali.zendesk.com/api/v2/users/746032525/tickets/requested.json")
    auth = 'Basic '+ Base64.encode64( 'zendesksupport@anomali.com:R4gwxTBvYCm8Fd!' ).chomp
    header = {'Authorization': auth}

    # Create the HTTP objects
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    # Send the request
    response = http.request(request)

    forum_tickets = JSON.parse(response.body)
    for ticket in forum_tickets["tickets"]
      if ticket["external_id"] == params[:external_id]
        return render json: { url: "https://anomali.zendesk.com/agent/tickets/#{ticket["id"]}",
                       text: "View #{ticket["status"].titleize} Zendesk Ticket",
                       title: title(ticket["status"]),
                       css_class: ticket["status"],
                       exists: true }
      end
    end

    render_ticket_json(the_ticket)
  end

  def render_ticket_json(the_ticket)
    if the_ticket.exists?
      render json: { url: the_ticket.url,
                     text: the_ticket.text,
                     title: the_ticket.title,
                     css_class: the_ticket.status,
                     exists: true }
    else
      render json: { text: 'Create Zendesk Ticket',
                     title: 'Click to create a new Ticket in Zendesk',
                     exists: false }
    end
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

end
