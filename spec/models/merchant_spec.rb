require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
    describe '::paginate' do
      it 'displays a variable amount of merchants per page' do
        create_list(:merchant, 55)

        expect(Merchant.paginate(1, 20).count).to eq(20)
        expect(Merchant.paginate(2, 20).count).to eq(20)
        expect(Merchant.paginate(3, 20).count).to eq(15)
      end
    end

    describe '::name_includes' do
      it 'returns the first alphabetically matched merchant with search term' do
        tee = create(:merchant, name: "Cotton Apparel")
        toy = create(:merchant, name: "Cat Cottage House")
        pen = create(:merchant, name: "Apricot Fountain Pens")
        pie = create(:merchant, name: "Vegan Pies")

        matched_merchant = Merchant.name_includes("cot")

        expect(matched_merchant.name).to eq(pen.name)
      end
    end

    describe '::sort_total_revenue' do
      it 'returns given number of merchants sorted by total revenue' do
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

        sorted_merchants = Merchant.sort_total_revenue(2)

        # expect(sorted_merchants.size).to eq(2)
        # expect(sorted_merchants.first).to eq(merchant1)
        # expect(sorted_merchants.last).to eq(merchant2)
      end
    end
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'returns the total revenue for a given merchant' do
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

        expect(merchant.total_revenue).to eq(561)
      end
    end
  end
end
