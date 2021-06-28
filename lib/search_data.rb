class SearchData 
  attr_reader :organizations, :tickets, :users, :entity_keys

  def initialize
    @organizations = JSON.parse(File.read('data/json/organizations.json'))
    @tickets = JSON.parse(File.read('data/json/tickets.json'))
    @users = JSON.parse(File.read('data/json/users.json'))
   
    @entity_keys = {}
    ticket_keys = []
    @tickets.each do |ticket|
      ticket_keys << ticket.keys
    end
    @entity_keys[:ticket] = ticket_keys.flatten.uniq

    organization_keys = []
    @organizations.each do |organization|
      organization_keys << organization.keys
    end
    @entity_keys[:organization] = organization_keys.flatten.uniq

    user_keys = []
    @users.each do |user|
      user_keys << user.keys
    end
    @entity_keys[:user] = user_keys.flatten.uniq
  end
end