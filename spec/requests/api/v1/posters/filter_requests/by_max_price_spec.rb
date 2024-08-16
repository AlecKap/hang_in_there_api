require "rails_helper"
require "test_data"

RSpec.describe "Filter posters by max price" do
  describe "GET /api/v1/posters?max_price=88" do
    it "returns all posters with a price less than or equal to 88" do
      posters_test_data
      expect(Poster.all.count).to eq(4)
      
      get "/api/v1/posters?max_price=88"

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].count).to eq(2)
      expect(data[:data].first[:attributes][:name]).to eq("MOTIVATION")
      expect(data[:data].second[:attributes][:name]).to eq("RESILIENCE")
    end
  end
end