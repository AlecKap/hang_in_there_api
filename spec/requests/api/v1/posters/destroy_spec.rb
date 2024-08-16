require "rails_helper"
require "test_data"

RSpec.describe "Posters destroy request" do
  describe "DELETE /api/v1/posters/:id" do
    before :each do
      posters_test_data
    end

    describe "happy path" do
      it "deletes a poster successfully" do
        expect(Poster.all.count).to eq(4)

        delete "/api/v1/posters/#{@poster1[:id]}"

        expect(response).to be_successful
        expect(response.status).to eq(204)

        expect(Poster.all.count).to eq(3)
      end
    end

    describe "sad path" do
      it "returns a 404 if poster does not exist" do
        expect(Poster.all.count).to eq(4)

        delete "/api/v1/posters/100"

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_an(Hash)
        expect(data[:errors].first[:status]).to eq("404")
        expect(data[:errors].first[:message]).to eq("Record not found")
      end
    end
  end
end