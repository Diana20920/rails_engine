require 'rails_helper'

RSpec.describe "Merchants API" do
  it "gets all merchants with maximum of 20 at a time" do
    create_list(:merchant, 21)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(20)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq("#{id}")

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'shows 20 merchants at a time' do
    create_list(:merchant, 95)

    get "/api/v1/merchants?per_page=50&page=2"

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(45)
  end

  describe 'sad paths' do
    it "returns error if record does not exist" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id + 1}"

      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(response.body).to match(/No record found for given ID/)
    end
  end
end
