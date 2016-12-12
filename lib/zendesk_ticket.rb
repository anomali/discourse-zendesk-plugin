class ZendeskTicket
  def initialize(params)
    @client = ZendeskAPI::Client.new do |config|
      # config.url = "#{ENV['ZENDESK_API_URL']}/api/v2" # e.g. https://support.mydesk.com
      config.url = "https://support.anomali.com/api/v2" # e.g. https://support.mydesk.com
      config.username = ENV['ZENDESK_USERNAME']
      config.token = ENV['ZENDESK_TOKEN']

      # require 'logger'
      # config.logger = Logger.new(File.expand_path("../../logs/zendesk.log", __FILE__))
    end
  end

  def url
    # ENV['ZENDESK_TICKET_URL'] => e.g. https://mydesk.newrelic.com
    "#{ENV['ZENDESK_TICKET_URL']}/agent/#/tickets/#{@ticket.id}"
  end

  def status
    @ticket.status
  end

  def text
    return "View #{status.titleize} Zendesk Ticket"
  end

  def title
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

  def exists?
    @ticket.present?
  end
end

# class DeskCase
#   def initialize(params)
#     @client = DeskApi.configure do |config|
#       # DeskApi should "just work" if ENVs are set. Otherwise, provide these...
#       # config.token           = ENV['DESK_TOKEN']
#       # config.token_secret    = ENV['DESK_TOKEN_SECRET']
#       # config.consumer_key    = ENV['DESK_CONSUMER_KEY']
#       # config.consumer_secret = ENV['DESK_CONSUMER_SECRET']
#       # config.endpoint        = ENV['DESK_ENDPOINT']
#     end
#   end
#
#   def url
#     "#{ENV['DESK_ENDPOINT']}/agent/case/#{@case.id}"
#   end
#
#   def status
#     @case.status
#   end
#
#   def text
#     "View #{status.titleize} Desk Case"
#   end
#
#   def title
#     case status
#       when 'new'        then 'Case is New. '
#       when 'open'       then 'Case is Open. '
#       when 'pending'    then 'Case is Pending. '
#       when 'resolved'   then 'Case has been Resolved. '
#       when 'closed'     then 'Case has been Closed. '
#       else 'Case status is unknown. '
#     end + 'Click to view in Desk'
#   end
#
#   def exists?
#     @case.present?
#   end
# end
