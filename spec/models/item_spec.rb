require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    describe '::paginate' do
      it 'displays a certain amount of items per page' do
        id_1 = create(:merchant).id
        id_2 = create(:merchant).id
        create_list(:item, 25, merchant_id: id_1)
        create_list(:item, 10, merchant_id: id_2)

        expect(Item.paginate(1, 20).count).to eq(20)
        expect(Item.paginate(2, 20).count).to eq(15)
      end
    end

    describe '::name_includes' do
      it 'returns all items with name that matches search term' do
        merchant = create(:merchant).id

        bottle = create(:item, merchant_id: merchant, name: "Black Hydroflask Water Bottle", unit_price: 35.22)
        lamp = create(:item, merchant_id: merchant, name: "Dimmable Desk Lamp", unit_price: 50.10)
        marker = create(:item, merchant_id: merchant, name: "Felt Tip Marker - Black", unit_price: 5.78)
        headphones = create(:item, merchant_id: merchant, name: "Wireless Black Headphones", unit_price: 149.99)
        frame = create(:item, merchant_id: merchant, name: "Allblack Matte Frame", unit_price: 1.99)

        matching_items = Item.name_includes("black")

        expect(matching_items.count).to eq(4)
        expect(matching_items.include?(lamp)).to eq(false)
        expect(matching_items.include?(headphones)).to eq(true)
      end
    end

    describe '::cost_more_than' do
      it 'returns all items that cost more than given price' do
        merchant = create(:merchant).id

        bottle = create(:item, merchant_id: merchant, name: "Black Hydroflask Water Bottle", unit_price: 35.22)
        lamp = create(:item, merchant_id: merchant, name: "Dimmable Desk Lamp", unit_price: 50.10)
        marker = create(:item, merchant_id: merchant, name: "Felt Tip Marker - Black", unit_price: 5.78)
        headphones = create(:item, merchant_id: merchant, name: "Wireless Black Headphones", unit_price: 149.99)
        frame = create(:item, merchant_id: merchant, name: "Allblack Matte Frame", unit_price: 1.99)

        matching_prices = Item.cost_more_than("50")

        expect(matching_prices.count).to eq(2)
        expect(matching_prices.include?(marker)).to eq(false)
        expect(matching_prices.include?(lamp)).to eq(true)
      end
    end

    describe '::cost_less_than' do
      it 'returns all items that cost less than given price' do
        merchant = create(:merchant).id

        bottle = create(:item, merchant_id: merchant, name: "Black Hydroflask Water Bottle", unit_price: 35.22)
        lamp = create(:item, merchant_id: merchant, name: "Dimmable Desk Lamp", unit_price: 50.10)
        marker = create(:item, merchant_id: merchant, name: "Felt Tip Marker - Black", unit_price: 5.78)
        headphones = create(:item, merchant_id: merchant, name: "Wireless Black Headphones", unit_price: 149.99)
        frame = create(:item, merchant_id: merchant, name: "Allblack Matte Frame", unit_price: 1.99)

        matching_prices = Item.cost_less_than("5")

        expect(matching_prices.count).to eq(1)
        expect(matching_prices.include?(bottle)).to eq(false)
        expect(matching_prices.include?(frame)).to eq(true)
      end
    end

    describe '::price_between' do
      it 'returns all items with unit price in the range provided' do
        merchant = create(:merchant).id

        bottle = create(:item, merchant_id: merchant, name: "Black Hydroflask Water Bottle", unit_price: 35.22)
        lamp = create(:item, merchant_id: merchant, name: "Dimmable Desk Lamp", unit_price: 50.10)
        marker = create(:item, merchant_id: merchant, name: "Felt Tip Marker - Black", unit_price: 5.78)
        headphones = create(:item, merchant_id: merchant, name: "Wireless Black Headphones", unit_price: 149.99)
        frame = create(:item, merchant_id: merchant, name: "Allblack Matte Frame", unit_price: 1.99)

        items = Item.price_between("50", "200")

        expect(items.count).to eq(2)
        expect(items.include?(frame)).to eq(false)
        expect(items.include?(lamp)).to eq(true)
      end
    end
  end
end
