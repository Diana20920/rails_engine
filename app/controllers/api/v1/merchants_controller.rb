class Api::V1::MerchantsController < ApplicationController

  def index
    page = params[:page].to_i
    per_page = params[:per_page].to_i
    render json: MerchantSerializer.new(Merchant.paginate(page, per_page))
  end

  def show
    @merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(@merchant)
  end
end
