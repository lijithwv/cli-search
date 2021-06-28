require "search"
require "search_data"
require "colorize"
require 'byebug'

RSpec.describe Search do
  let(:search) {Search.new}
  let(:search_data) {SearchData.new}

  describe "organization search result" do
    let(:organization_id) {search_data.organizations.first["_id"]}
    let(:search_input1) {
      search_input = {
        :key => "_id",
        :value => organization_id
      }
    }
    let(:search_input2) {
      search_input = {
        :key => "_id",
        :value => "0"
      }
    }

    it "should return relevant organisation data" do
      result = search.by_organization search_input1
      expect(result.first[:organization1]["_id"]).to eq organization_id
      expect(result.first[:organization1][:organization1_tickets].first["_id"]).to eq search_data.tickets.select{|x| x["organization_id"] == organization_id}.first["_id"]
      expect(result.first[:organization1][:organization1_users].first["_id"]).to eq search_data.users.select{|x| x["organization_id"] == organization_id}.first["_id"]
    end

    it "should return empty result for non-existant record" do
      result = search.by_organization search_input2
      expect(result).to eq []
    end
  end

  describe "ticket search result" do
    let(:ticket_id) {search_data.tickets.first["_id"]}
    let(:search_input1) {
      search_input = {
        :key => "_id",
        :value => ticket_id
      }
    }
    let(:search_input2) {
      search_input = {
        :key => "_id",
        :value => "0"
      }
    }

    it "should return relevant ticket data" do
      result = search.by_ticket search_input1
      expect(result.first[:ticket1]["_id"]).to eq ticket_id
      expect(result.first[:ticket1][:ticket1_organization].first["_id"]).to eq search_data.organizations.select{|x| x["_id"] == result.first[:ticket1]["organization_id"]}.first["_id"]
      expect(result.first[:ticket1][:ticket1_submitter].first["_id"]).to eq search_data.users.select{|x| x["_id"] == result.first[:ticket1]["submitter_id"]}.first["_id"]
      expect(result.first[:ticket1][:ticket1_assignee].first["_id"]).to eq search_data.users.select{|x| x["_id"] == result.first[:ticket1]["assignee_id"]}.first["_id"]
    end

    it "should return empty result for non-existant record" do
      result = search.by_ticket search_input2
      expect(result).to eq []
    end
  end

  describe "user search result" do
    let(:user_id) {search_data.users.first["_id"]}
    let(:search_input1) {
      search_input = {
        :key => "_id",
        :value => user_id
      }
    }
    let(:search_input2) {
      search_input = {
        :key => "_id",
        :value => "0"
      }
    }

    it "should return relevant user data" do
      result = search.by_user search_input1
      expect(result.first[:user1]["_id"]).to eq user_id
      expect(result.first[:user1][:user1_organization].first["_id"]).to eq search_data.organizations.select{|x| x["_id"] == result.first[:user1]["organization_id"]}.first["_id"]
      expect(result.first[:user1][:user1_tickets].first["_id"]).to eq search_data.tickets.select{|x| x["submitter_id"] == result.first[:user1]["_id"] || x["assignee_id"] == result.first[:user1]["_id"]}.first["_id"]
    end

    it "should return empty result for non-existant record" do
      result = search.by_user search_input2
      expect(result).to eq []
    end
  end
end