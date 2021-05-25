class Api::V1::MerchantsController < ApplicationController

  def index
    if params[:per_page]
      page = params[:page].to_i
      per_page = params[:per_page].to_i
      render json: MerchantSerializer.new(Merchant.paginate(page, per_page))
    else
      render json: MerchantSerializer.new(Merchant.paginate)
    end 
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end
