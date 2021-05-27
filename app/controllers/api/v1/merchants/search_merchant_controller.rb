class Api::V1::Merchants::SearchMerchantController < ApplicationController
  def show
    merchant = Merchant.name_includes(params[:name])
    if merchant.nil?
      render json: { data: {} }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
