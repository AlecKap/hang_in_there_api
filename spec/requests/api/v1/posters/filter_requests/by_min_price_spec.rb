require "rails_helper"
require "test_data"

RSpec.describe "Filter posters by min price" do
  describe "GET /api/v1/posters?min_price=88" do
    it "returns all posters with a price greater than or equal to 88" do
      posters_test_data
      expect(Poster.all.count).to eq(4)
      
      get "/api/v1/posters?min_price=88"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].count).to eq(2)
      expect(data[:data].first[:attributes][:name]).to eq("REGRET")
      expect(data[:data].second[:attributes][:name]).to eq("SUCCESS")
    end
  end
end