class Menu 
  def self.main_menu
    puts "\n----------------------------------------"
    puts "Select search options:".bold
    puts "* Press 1 to search by Organization data".light_blue
    puts "* Press 2 to search by Ticket data".light_blue
    puts "* Press 3 to search by User data".light_blue
    puts "* Press 4 to list all searchable fields".light_blue
    puts "\nType 'quit' to exit.".magenta
    print "Enter command: ".cyan
  end

  def self.help
    puts "Help".bold
    puts "  help\t\t\t:show this help menu".green
    puts "Search".bold
    puts "  1\t\t\t:search by Organization data".green
    puts "  2\t\t\t:search by Ticket data".green
    puts "  3\t\t\t:search by User data".green
    puts "List".bold
    puts "  4\t\t\t:list all searchable fields".green
    puts "Quit".bold
    puts "  quit\t\t\t:quit the program".green
    puts "  exit\t\t\t:alias for quit".green
  end
end