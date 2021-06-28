require "list"
require "colorize"
require "json"

RSpec.describe List do
  let(:organizations) {JSON.parse(File.read('data/json/organizations.json'))}
  let(:tickets) {JSON.parse(File.read('data/json/tickets.json'))}
  let(:users) {JSON.parse(File.read('data/json/users.json'))}
  let(:entity_keys) {
    entity_keys = {}
    ticket_keys = []
    tickets.each do |ticket|
      ticket_keys << ticket.keys
    end
    entity_keys[:ticket] = ticket_keys.flatten.uniq

    organization_keys = []
    organizations.each do |organization|
      organization_keys << organization.keys
    end
    entity_keys[:organization] = organization_keys.flatten.uniq

    user_keys = []
    users.each do |user|
      user_keys << user.keys
    end
    entity_keys[:user] = user_keys.flatten.uniq

    entity_keys
  }

  describe 'list all searchable fields should list all keys from data entities' do
    subject "list searchable fields" do
      capture_output do
        List.fields entity_keys
      end
    end

    its(:stdout) { 
      entity_keys.keys.each do |key_item|
        is_expected.to include "Searchable fields for #{key_item.to_s.capitalize}"
        entity_keys[key_item].each do |item|
          is_expected.to include item
        end
      end
    }
  end
end