require "rails_helper"
require "test_data"

RSpec.describe "Posters create request" do
  describe "POST /api/v1/posters" do
    before :each do
      posters_test_data
    end

    describe "happy path" do
      it "creates a new poster successfully" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "PERSERVERENCE",
          description: "Life finds a way.",
          price: 99.00,
          year: 1988,
          vintage: true,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type': 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)
        created_poster = Poster.last

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(Poster.all.count).to eq(5)

        expect(created_poster.name).to eq(body[:name])
        expect(created_poster.description).to eq(body[:description])
        expect(created_poster.price).to eq(body[:price])
        expect(created_poster.year).to eq(body[:year])
        expect(created_poster.vintage).to eq(body[:vintage])
        expect(created_poster.img_url).to eq(body[:img_url])
      end
    end

    describe "sad path" do
      it "returns a 422 if name has already been taken" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "REGRET",
          description: "Hard work rarely pays off.",
          price: 89.00,
          year: 2018,
          vintage: true,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Name has already been taken")
        expect(Poster.all.count).to eq(4)
      end

      it "returns a 422 if name is missing" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          description: "Hard work rarely pays off.",
          price: 89.00,
          year: 2018,
          vintage: true,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Name can't be blank")
        expect(Poster.all.count).to eq(4)
      end

      it "returns a 422 if description is missing" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "Missing Description",
          price: 89.00,
          year: 2018,
          vintage: true,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Description can't be blank")
        expect(Poster.all.count).to eq(4)
      end

      it "returns a 422 if vintage is missing" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "Missing Vintage",
          description: "Hard work rarely pays off.",
          price: 89.00,
          year: 2018,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Vintage is not included in the list")
        expect(Poster.all.count).to eq(4)
      end
      
      it "returns a 422 if price is missing" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "Missing Price",
          description: "Hard work rarely pays off.",
          vintage: true,
          year: 2018,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Price can't be blank, Price is not a number")
        expect(Poster.all.count).to eq(4)
      end
      
      it "returns a 422 if year is missing" do
        expect(Poster.all.count).to eq(4)
        
        body = {
          name: "Missing Year",
          description: "Hard work rarely pays off.",
          vintage: true,
          price: 89.00,
          img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
        }
        
        headers = { 'Content-Type' => 'application/json' }

        post "/api/v1/posters", headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data.count).to eq(1)
        expect(data).to have_key(:errors)
        expect(data[:errors]).to be_an(Array)

        error = data[:errors].first

        expect(error.count).to eq(2)
        expect(error).to have_key(:status)
        expect(error).to have_key(:message)
        expect(error[:status]).to eq("422")
        expect(error[:message]).to eq("Year can't be blank, Year is not a number")
        expect(Poster.all.count).to eq(4)
      end
    end
  end
end