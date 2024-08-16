require "rails_helper"
require "test_data"

RSpec.describe "Sort posters by created_at asc" do
  describe "GET /api/v1/posters?sort=asc" do
    it "returns all posters sorted by created_at asc" do
      posters_test_data
      
      get "/api/v1/posters?sort=asc"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].count).to eq(4)
      expect(data[:data].first[:attributes][:name]).to eq("SUCCESS")
      expect(data[:data].second[:attributes][:name]).to eq("RESILIENCE")
      expect(data[:data].third[:attributes][:name]).to eq("MOTIVATION")
      expect(data[:data].last[:attributes][:name]).to eq("REGRET")
    end
  end
end