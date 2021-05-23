require 'rails_helper'

RSpec.describe "Merchants API" do
  it "gets all merchants with maximum of 20 at a time" do
    create_list(:merchant, 21)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  it "can get one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end

  xit "returns error if record does not exist" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id + 1}"

    expect(response).to_not be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    # expect(response).to have_http_status(404)
    # expect(response.body).to match(/Couldn't find Merchant/)
    expect(response).to raise_error(ActiveRecord::RecordNotFound)
    expect(response).to have_content("Couldn't find Merchant with 'id'=#{id}")
  end

  it "gets all items for a given merchant id" do
    id = create(:merchant).id
    create_list(:item, 10, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(10)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_an(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to eq(id)
    end
  end
end
