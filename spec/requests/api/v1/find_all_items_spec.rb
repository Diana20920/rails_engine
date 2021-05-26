require 'rails_helper'

RSpec.describe 'Find Items' do
  describe 'Returns all items' do
    before :each do
      merchant = create(:merchant).id
      @bottle = create(:item, merchant_id: merchant, name: "Black Hydroflask Water Bottle", unit_price: 35.22)
      @lamp = create(:item, merchant_id: merchant, name: "Dimmable Desk Lamp", unit_price: 50.10)
      @marker = create(:item, merchant_id: merchant, name: "Felt Tip Marker - Black", unit_price: 5.78)
      @headphones = create(:item, merchant_id: merchant, name: "Wireless Black Headphones", unit_price: 149.99)
      @frame = create(:item, merchant_id: merchant, name: "Allblack Matte Frame", unit_price: 1.99)
    end

    it 'That match a search term' do
      search_term = "black"

      get "/api/v1/items/find_all?name=#{search_term}"

      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      matching_items = items[:data].map do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
      expect(matching_items.count).to eq(4)
    end

    it 'That match a minimum price' do
      minimum_price = "50"
      get "/api/v1/items/find?min_price=#{minimum_price}"

      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      matching_items = items[:data].map do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
      expect(matching_items.count).to eq(2)
    end
  end
end
