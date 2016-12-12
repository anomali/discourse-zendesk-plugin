class NewZendeskTicket < ZendeskTicket
  def initialize(params)
    super
    @url = params[:post_url]
    @html_comment = params[:html_comment]
    @comment = format_comment
    @ticket = @client.tickets.create(params[:ticket_data].merge(additional_data))
  end

  private

  def format_comment
    body_to_text = Nokogiri::HTML(@html_comment).text
    return "Link to forum topic:\n#{@url}\n\nComment:\n#{body_to_text}"
  end

  def additional_data
    { :comment => { :value => @comment }, :tags => ['forum-test'] }
  end
end

# class NewZendeskTicket < ZendeskTicket
#   def initialize(params)
#     super
#     @url = params[:post_url]
#     @topic_title = params[:case_data][:subject].sub(/^\[Community\] /, '')
#     @html_comment = params[:html_comment]
#     params[:case_data][:message][:body] = format_comment
#     @case = @client.cases.create(params[:case_data])
#   end
#
#   private
#
#   def format_comment
#     body_to_text = Nokogiri::HTML(@html_comment).text
#     'This support case has been created on your behalf by the '\
#     'Coinbase Support team in reference to your post on our '\
#     'Community forum. We\'ll follow up with you directly via this '\
#     'email ticket. We look forward to resolving your issue.'\
#     "\n\nLink to topic: #{@url}"\
#     "\n\n#{@topic_title}"\
#     "\n\n#{body_to_text}"
#   end
# end
