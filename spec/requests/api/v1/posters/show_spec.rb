require "rails_helper"
require "test_data"

RSpec.describe "Posters show request" do
  describe "GET /api/v1/posters/:id" do
    before :each do
      posters_test_data
    end

    it "returns a single poster by id" do
      id = @poster1.id

      get "/api/v1/posters/#{id}"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.count).to eq(1)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_an(Hash)

      poster = data[:data]
      expect(poster).to have_key(:id)
      expect(poster).to have_key(:type)
      expect(poster).to have_key(:attributes)

      expect(poster[:type]).to eq('posters')
      expect(poster[:id]).to be_a(String)
      expect(poster[:attributes]).to be_a(Hash)

      poster_attributes = poster[:attributes]
      expect(poster_attributes).to have_key(:name)
      expect(poster_attributes).to have_key(:description)
      expect(poster_attributes).to have_key(:price)
      expect(poster_attributes).to have_key(:year)
      expect(poster_attributes).to have_key(:vintage)
      expect(poster_attributes).to have_key(:img_url)

      expect(poster_attributes[:name]).to be_a(String)
      expect(poster_attributes[:description]).to be_a(String)
      expect(poster_attributes[:price]).to be_a(Float)
      expect(poster_attributes[:year]).to be_an(Integer)
      expect(poster_attributes[:vintage]).to be(true).or be(false)
      expect(poster_attributes[:img_url]).to be_a(String)
    end

    it "returns a 404 if the poster is not found" do
      id = 0

      get "/api/v1/posters/#{id}"

      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_an(Hash)
      expect(data.count).to eq(1)
      expect(data).to have_key(:errors)
      expect(data[:errors]).to be_an(Array)

      error = data[:errors].first
      expect(error.count).to eq(2)
      expect(error).to have_key(:status)
      expect(error).to have_key(:message)
      expect(error[:status]).to eq("404")
      expect(error[:message]).to eq("Record not found")
    end
  end
end