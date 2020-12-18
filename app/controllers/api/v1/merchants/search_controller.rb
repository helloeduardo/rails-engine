class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.multi_search(attribute, value)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.single_search(attribute, value)
    render json: MerchantSerializer.new(merchant)
  end

  def most_revenue
    merchants = Merchant.most_revenue(merchant_params[:quantity].to_i)
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = Merchant.most_items(merchant_params[:quantity].to_i)
    render json: MerchantSerializer.new(merchants)
  end

  private
    def merchant_params
      params.permit(:name, :created_at, :updated_at, :quantity)
    end

    def attribute
      merchant_params.keys.first
    end

    def value
      merchant_params[attribute]
    end
end
