class Search
  def initialize 
  end

  def by_organization search_input
    return if search_input.nil? || search_input.empty?
    search_data = SearchData.new
    search_result = []
    search_key = search_input[:key]
    search_value = search_input[:value]

    if search_data.organizations.first[search_key].is_a?(Array)
      inscope_organizations = search_data.organizations.select{|x| x[search_key].include?(search_value.to_s)}
    else
      inscope_organizations = search_data.organizations.select{|x| x[search_key].to_s.strip == search_value.to_s}
    end

    inscope_organizations.each_with_index do |organization_item, index|
      item_index = ("organization"+(index+1).to_s)
      item_symbol = item_index.to_sym
      search_result_item = Hash.new
      search_result_item[item_symbol] = organization_item
      search_result_item[item_symbol][("#{item_index}_tickets").to_sym] = search_data.tickets.select{|x| x["organization_id"] == organization_item["_id"]}
      search_result_item[item_symbol][("#{item_index}_users").to_sym] = search_data.users.select{|x| x["organization_id"] == organization_item["_id"]}
    
      search_result << search_result_item
    end

    search_result
  end

  def by_ticket search_input
    return if search_input.nil? || search_input.empty?
    search_data = SearchData.new
    search_result = []
    search_key = search_input[:key]
    search_value = search_input[:value]

    if search_data.tickets.first[search_key].is_a?(Array)
      inscope_tickets = search_data.tickets.select{|x| x[search_key].include?(search_value.to_s)}
    else
      inscope_tickets = search_data.tickets.select{|x| x[search_key].to_s.strip == search_value.to_s}
    end

    inscope_tickets.each_with_index do |ticket_item, index|
      item_index = ("ticket"+(index+1).to_s)
      item_symbol = item_index.to_sym
      search_result_item = Hash.new
      search_result_item[item_symbol] = ticket_item
      search_result_item[item_symbol][("#{item_index}_organization").to_sym] = search_data.organizations.select{|x| x["_id"] == ticket_item["organization_id"]}
      search_result_item[item_symbol][("#{item_index}_submitter").to_sym] = search_data.users.select{|x| x["_id"] == ticket_item["submitter_id"]}
      search_result_item[item_symbol][("#{item_index}_assignee").to_sym] = search_data.users.select{|x| x["_id"] == ticket_item["assignee_id"]}

      search_result << search_result_item
    end

    search_result
  end

  def by_user search_input
    return if search_input.nil? || search_input.empty?
    search_data = SearchData.new
    search_result = []
    search_key = search_input[:key]
    search_value = search_input[:value]

    if search_data.users.first[search_key].is_a?(Array)
      inscope_users = search_data.users.select{|x| x[search_key].include?(search_value.to_s)}
    else
      inscope_users = search_data.users.select{|x| x[search_key].to_s.strip == search_value.to_s}
    end

    inscope_users.each_with_index do |user_item, index|
      item_index = ("user"+(index+1).to_s)
      item_symbol = item_index.to_sym
      search_result_item = Hash.new
      search_result_item[item_symbol] = user_item
      search_result_item[item_symbol][("#{item_index}_organization").to_sym] = search_data.organizations.filter{|x| x["_id"] == user_item["organization_id"]}
      search_result_item[item_symbol][("#{item_index}_tickets").to_sym] = search_data.tickets.filter{|x| x["submitter_id"] == user_item["_id"] || x["assignee_id"] == user_item["_id"]}
      search_result << search_result_item
    end

    search_result
  end

  def get_search_input entity, entity_keys
    search_input = Hash.new
    search_key = search_value = nil

    puts "\nType 'menu' to go back to main menu".magenta
    print "Enter #{entity} search field: ".cyan
    input = gets.chomp.strip
    return if input == 'menu'
    
    valid_key = Search.validate_key input, entity_keys
    unless valid_key
      puts "Invalid field!".red
      puts "Hint: Have a look at all searchable fields for this data type"
      return
    end
    search_key = input

    print "Enter #{entity} search value: ".cyan
    input = gets.chomp.strip
    return if input == 'menu'
    search_value = input

    search_input[:key] = search_key
    search_input[:value] = search_value

    search_input
  end

  def self.validate_key input_key, entity_keys
    return true if entity_keys.include?(input_key)
    false
  end
end