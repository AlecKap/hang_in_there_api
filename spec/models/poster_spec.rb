require 'rails_helper'
require 'test_data'

RSpec.describe Poster, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :year }
    it { should validate_numericality_of(:year).only_integer }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price)}
    it { should validate_inclusion_of(:vintage).in_array([true, false]) }
  end

  describe 'class methods' do
    before :each do
      posters_test_data             
    end

    describe '.order_by_created_at_asc' do
      it 'orders posters by created_at in ascending order' do
        expect(Poster.order_by_created_at_asc).to eq([@poster4, @poster3, @poster2, @poster1])
      end
    end

    describe '.order_by_created_at_desc' do
      it 'orders posters by created_at in descending order' do
        expect(Poster.order_by_created_at_desc).to eq([@poster1, @poster2, @poster3, @poster4])
      end
    end

    describe '.search_by_name' do
      it 'returns posters that match the search term' do
        expect(Poster.search_by_name("ce")).to eq([@poster3, @poster4])
      end
    end

    describe '.filter_by_max_price' do
      it 'returns posters that are less than or equal to the max price' do
        expect(Poster.filter_by_max_price(88.00)).to eq([@poster2, @poster3])
      end
    end

    describe '.filter_by_min_price' do
      it 'returns posters that are greater than or equal to the min price' do
        expect(Poster.filter_by_min_price(88.00)).to eq([@poster1, @poster4])
      end
    end
  end
end
