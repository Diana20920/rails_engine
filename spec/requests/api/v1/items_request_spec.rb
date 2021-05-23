require 'rails_helper'

RSpec.describe 'Items API' do
  it "gets all items with maximum of 20 at a time" do
    id = create(:merchant).id
    create_list(:item, 21, merchant_id: id)

    get "/api/v1/merchants/#{id}/items" # I think it should just be items, not namespaced!

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(20)

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

  it "can get one item" do
    id = create(:merchant).id
    create_list(:item, 21, merchant_id: id)
    item_id = Item.last.id

    get "/api/v1/merchants/#{id}/items/#{item_id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

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

  xit "can create an item" do
    merchant    = create(:merchant)
    item_params = ({
      name: 'Imported Dollar Plant',
      description: 'Beautiful round leaves! This plant is said to help you get that cash in!',
      unit_price: 10,
      merchant_id: merchant.id
      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants/#{merchant.id}/items", headers: headers, params: JSON.generate(item: item_params)

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

    patch "/api/v1/merchants/#{merchant_id}/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item.id)

    expect(response).to be_successful
    expect(item.unit_price).to_not eq(previous_price)
    expect(item.unit_price).to eq(4586)
  end

  it "can delete an item" do
    merchant_id = create(:merchant).id
    item        = create(:item, merchant_id: merchant_id)

    expect(Item.count).to eq(1)

    delete "/api/v1/merchants/#{merchant_id}/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  xit "gets the merchant data for a given item ID" do
    merchant = create(:merchant)
    create_list(:item, 21, merchant_id: merchant.id)
    item_id = Item.last.id

    get "/api/v1/items/#{item_id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(Integer)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end
