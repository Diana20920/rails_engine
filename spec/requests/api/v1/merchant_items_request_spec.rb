require 'rails_helper'

RSpec.describe "Items associated with one Merchant" do
  before :each do
    @id = create(:merchant).id
    create_list(:item, 10, merchant_id: @id)
  end
  it "returns all items for one merchant" do
    get "/api/v1/merchants/#{@id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(10)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to eq(@id)
    end
  end

  describe 'sad paths' do
    it "returns a 404 if merchant is not found" do
      get "/api/v1/merchants/#{@id + 1}"

      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(response.body).to match(/No record found for given ID/)
    end
  end
end
