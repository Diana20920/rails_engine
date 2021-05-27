require 'rails_helper'

RSpec.describe 'Find Merchant' do
  describe 'Returns one merchant' do
    it 'That matches a search term' do
      tee = create(:merchant, name: "Cotton Apparel")
      toy = create(:merchant, name: "Cat Cottage House")
      pen = create(:merchant, name: "Apricot Fountain Pens")
      pie = create(:merchant, name: "Vegan Pies")

      term = "cot"
      get "/api/v1/merchants/find?name=#{term}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq("#{pen.id}")

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to eq(pen.name)

      expect(merchant.count).to eq(1)
    end
  end

  describe 'Sad Path' do
    it 'Returns an object if no merchant is found' do
      pen = create(:merchant, name: "Apricot Fountain Pens")
      pie = create(:merchant, name: "Vegan Pies")

      term = "blue"
      get "/api/v1/merchants/find?name=#{term}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to_not have_key(:id)
      expect(merchant[:data].empty?).to eq(true)
    end 
  end
end
