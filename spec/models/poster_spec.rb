require 'rails_helper'

RSpec.describe Poster, type: :model do
  describe 'class methods' do
    before :each do
      @poster1 = Poster.create(name: "REGRET",
                                description: "Hard work rarely pays off.",
                                price: 89.00,
                                year: 2018,
                                vintage: true,
                                img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                                created_at: 1.days.ago)
        
        @poster2 = Poster.create(name: "MOTIVATION",
                                description: "You can do it!",
                                price: 77.00,
                                year: 2017,
                                vintage: true,
                                img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                                created_at: 2.days.ago)

        @poster3 = Poster.create(name: "RESILIENCE",
                                description: "Stick with it!",
                                price: 87.00,
                                year: 2015,
                                vintage: true,
                                img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d",
                                created_at: 3.days.ago)
    end
    
    describe '.order_by_created_at_asc' do
      it 'orders posters by created_at in ascending order' do
        expect(Poster.order_by_created_at_asc).to eq([@poster3, @poster2, @poster1])
      end
    end

    describe '.order_by_created_at_desc' do
      it 'orders posters by created_at in descending order' do
        expect(Poster.order_by_created_at_desc).to eq([@poster1, @poster2, @poster3])
      end
    end
  end
end
