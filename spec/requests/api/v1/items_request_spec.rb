require 'rails_helper'

RSpec.describe 'Items API' do
  it "gets all items with maximum of 20 at a time" do
    id = create(:merchant).id
    create_list(:item, 21, merchant_id: id)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(20)

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
      expect(item[:attributes][:merchant_id]).to eq(id)
    end
  end

  it "can get one item" do
    id = create(:merchant).id
    create_list(:item, 21, merchant_id: id)
    item_id = Item.last.id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_an(String)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to eq(id)
  end

  it "can create an item" do
    merchant    = create(:merchant)
    item_params = ({
      name: 'Imported Dollar Plant',
      description: 'Beautiful round leaves! This plant is said to help you get that cash in!',
      unit_price: 10,
      merchant_id: merchant.id
      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant_id    = create(:merchant).id
    item           = create(:item, merchant_id: merchant_id)
    previous_price = Item.last.unit_price
    item_params    = { unit_price: 4586}
    headers        = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item.id)

    expect(response).to be_successful
    expect(item.unit_price).to_not eq(previous_price)
    expect(item.unit_price).to eq(4586)
  end

  it "can delete an item" do
    merchant_id = create(:merchant).id
    item        = create(:item, merchant_id: merchant_id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "gets the merchant data for a given item ID" do
    merchant = create(:merchant)
    create_list(:item, 21, merchant_id: merchant.id)
    item_id = Item.last.id

    get "/api/v1/items/#{item_id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it "shows 20 items at a time" do
    id = create(:merchant).id
    create_list(:item, 90, merchant_id: id)

    get "/api/v1/items?per_page=50&page=2"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(40)
  end

  describe 'Edge Cases' do
    it "Attribute missing when creating Item" do
      merchant    = create(:merchant)
      item_params = ({
        description: 'Beautiful round leaves! This plant is said to help you get that cash in!',
        unit_price: 10,
        merchant_id: merchant.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)
    end
  end
end
