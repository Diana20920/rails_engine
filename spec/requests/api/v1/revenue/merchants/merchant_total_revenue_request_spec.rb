require 'rails_helper'

RSpec.describe 'Merchant Total Revenue' do
  it 'Returns given merchant with total revenue' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 20, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 50.10, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 4, merchant_id: merchant.id)
    invoice1 = create(:invoice, status: "shipped", merchant_id: merchant.id)
    invoice2 = create(:invoice, status: "shipped", merchant_id: merchant.id)
    create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 3)
    create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 10)
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

  xit 'Returns variable quanty of merchants with most revenue' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, unit_price: 20, merchant_id: merchant1.id)
    item2 = create(:item, unit_price: 50.10, merchant_id: merchant1.id)
    item3 = create(:item, unit_price: 4, merchant_id: merchant2.id)
    invoice1 = create(:invoice, status: "shipped", merchant_id: merchant1.id)
    invoice2 = create(:invoice, status: "shipped", merchant_id: merchant2.id)
    create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 3)
    create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 10)
    transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice2.id)

    num = "2"
    get "/api/v1/revenue/merchants?quantity=#{num}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(2)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes]).to have_key(:revenue)
      expect(merchant[:attributes][:revenue]).to be_a(Float)
    end
    expect(merchants[:data][0]).to eq(merchant1)
  end
end
