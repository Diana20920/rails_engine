class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    merchants = Merchant.sort_total_revenue(params[:quantity].to_i)
    render json: MerchantSortRevenueSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
