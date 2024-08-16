require "rails_helper"
require "test_data"

RSpec.describe "Filter posters by name" do
  describe "GET /api/v1/posters?name=RE" do
    it "returns all posters sorted by created_at asc" do
      posters_test_data
      expect(Poster.all.count).to eq(4)
      
      get "/api/v1/posters?name=RE"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:data].count).to eq(2)
      expect(data[:data].first[:attributes][:name]).to eq("REGRET")
      expect(data[:data].last[:attributes][:name]).to eq("RESILIENCE")
    end
  end
end