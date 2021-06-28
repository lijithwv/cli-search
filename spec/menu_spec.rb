require "menu"
require "colorize"

RSpec.describe Menu do
  describe 'main menu output should match all available menu options' do
    subject "main menu" do
      capture_output do
        Menu.main_menu
      end
    end

    its(:stdout) { 
      is_expected.to include "Select search options:",
        "Enter command:"
        "* Press 1 to search by Organization data"
        "* Press 2 to search by Ticket data"
        "* Press 3 to search by User data"
        "* Press 4 to list all searchable fields"
        "\nType 'quit' to exit."
    }
  end

  describe 'help menu output should match all available menu options' do
    subject "help menu" do
      capture_output do
        Menu.help
      end
    end

    its(:stdout) { 
      is_expected.to include "Help"
      "  help\t\t\t:show this help menu"
      "Search"
      "  1\t\t\t:search by Organization data"
      "  2\t\t\t:search by Ticket data"
      "  3\t\t\t:search by User data"
      "List"
      "  4\t\t\t:list all searchable fields"
      "Quit"
      "  quit\t\t\t:quit the program"
      "  exit\t\t\t:alias for quit"
    }
  end
end