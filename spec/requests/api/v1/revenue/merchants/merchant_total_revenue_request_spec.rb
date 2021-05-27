require 'rails_helper'

RSpec.describe 'Given Merchant' do
  it 'Returns with total revenue' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 20, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 50.10, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 4, merchant_id: merchant.id)
    invoice1 = create(:invoice, status: "shipped", merchant_id: merchant.id)
    invoice2 = create(:invoice, status: "shipped", merchant_id: merchant.id)
    ii1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 3)
    ii2 = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 10)
    transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice2.id)

    get "/api/v1/revenue/merchants/#{merchant.id}"

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(parsed[:data]).to have_key(:id)
    expect(parsed[:data][:id]).to eq("#{merchant.id}")
    expect(parsed[:data]).to have_key(:type)

    expect(parsed[:data][:attributes]).to have_key(:revenue)
    expect(parsed[:data][:attributes][:revenue]).to be_a(Float)
  end
end
