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
  end
end
