class Api::V1::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    merchant_items = @merchant.items.limit(20)
    render json: merchant_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    merchant_item = @merchant.items.find(params[:id])
    render json: merchant_item
  end

  def create
    render json: Item.create(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
