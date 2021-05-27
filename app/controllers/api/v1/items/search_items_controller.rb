class Api::V1::Items::SearchItemsController < ApplicationController
  def index
    if params[:name]
      matching_items = Item.name_includes(params[:name])
      render json: ItemSerializer.new(matching_items)
    else
      matching_prices = Item.cost_more_than(params[:min_price])
      render json:ItemSerializer.new(matching_prices)
    end
  end
end
