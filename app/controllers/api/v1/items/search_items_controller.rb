class Api::V1::Items::SearchItemsController < ApplicationController
  def index
    matching_items = Item.name_includes(params[:name])
    render json: ItemSerializer.new(matching_items)
  end
end
