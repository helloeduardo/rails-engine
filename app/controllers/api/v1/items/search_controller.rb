class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.multi_search(attribute, value)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.single_search(attribute, value)
    render json: ItemSerializer.new(item)
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :created_at, :updated_at)
    end

    def attribute
      item_params.keys.first
    end

    def value
      item_params[attribute]
    end
end
