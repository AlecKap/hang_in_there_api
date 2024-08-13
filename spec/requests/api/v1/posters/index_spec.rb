require 'rails_helper'
require 'test_data'

RSpec.describe 'Posters index request' do
  describe 'GET /api/v1/posters' do
    it 'returns a list of posters' do
      posters_test_data

      get '/api/v1/posters'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to have_key(:meta)
      expect(data[:meta]).to have_key(:count)
      expect(data[:meta][:count]).to be_an(Integer)
      expect(data[:meta][:count]).to eq(4)

      expect(data).to have_key(:data)
      expect(data[:data]).to be_an(Array)
      expect(data[:data].count).to eq(4)

      poster = data[:data].first
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
  end
end