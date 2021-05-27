class Api::V1::Items::SearchItemsController < ApplicationController
  def index
    if params[:name]
      matching_items = Item.name_includes(params[:name])
      render json: ItemSerializer.new(matching_items)
    elsif params[:min_price] && params[:max_price]
      items = Item.price_between(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(items)
    elsif params[:max_price]
      matching_prices = Item.cost_less_than(params[:max_price])
      render json:ItemSerializer.new(matching_prices)
    else params[:min_price]
      matching_prices = Item.cost_more_than(params[:min_price])
      render json:ItemSerializer.new(matching_prices)
    end
  end
end
