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
  end
end
