class ExistingZendeskTicket < ZendeskTicket
  def initialize(existing_id)
    super
    @ticket = @client.search(:query => existing_id).to_a.try(:first)
  end
end

# class ExistingZendeskTicket < ZendeskTicket
#   def initialize(existing_id)
#     super
#     @case = @client.cases.find("e-#{existing_id}") rescue nil
#   end
# end
