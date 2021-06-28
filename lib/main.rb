class Main
  def self.run
    begin
      search_data = SearchData.new
      puts "Welcome to Zendesk Search Application".magenta
    rescue => exception
      Main.report_error "Data load", exception
      exit
    end

    while true
      begin
        # display main menu
        Menu.main_menu
        input = gets.chomp.strip
        break if input == "quit" || input == "exit"
        search_result = []

        # loop through cases based on user input
        case input
        when "1" # search by organization
          search = Search.new
          search_input = search.get_search_input "organization", search_data.entity_keys[:organization]
          unless search_input.nil? || search_input.empty?
            search_result = search.by_organization search_input
            Result.display search_result
          end
        when "2" # search by ticket
          search = Search.new
          search_input = search.get_search_input "ticket", search_data.entity_keys[:ticket]
          unless search_input.nil? || search_input.empty?
            search_result = search.by_ticket search_input
            Result.display search_result
          end
        when "3" # search by user
          search = Search.new
          search_input = search.get_search_input "user", search_data.entity_keys[:user]
          unless search_input.nil? || search_input.empty?
            search_result = search.by_user search_input
            Result.display search_result
          end
        when "4" # list all searchable fields
          List.fields search_data.entity_keys
        when "help"
          Menu.help
        else
          puts "\nInvalid command, type 'help' to see a list of available commands".red
        end
      rescue => exception
        Main.report_error "Search", exception
      end
    end
  end

  def self.report_error error_type, exception
    puts "\n#{error_type} error!".red
    puts exception.message
    puts exception.backtrace
  end
end