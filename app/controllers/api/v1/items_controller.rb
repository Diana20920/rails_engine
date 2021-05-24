class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    else
      render json: ItemSerializer.new(Item.all.limit(20))
    # @merchant = Merchant.find(params[:merchant_id])
    # merchant_items = @merchant.items.limit(20)
    # render json: merchant_items
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
    # @merchant = Merchant.find(params[:merchant_id])
    # merchant_item = @merchant.items.find(params[:id])
    # render json: merchant_item
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: 201
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
