class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.multi_search(attribute, value)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.single_search(attribute, value)
    render json: MerchantSerializer.new(merchant)
  end

  private
    def merchant_params
      params.permit(:name, :created_at, :updated_at)
    end

    def attribute
      merchant_params.keys.first
    end

    def value
      merchant_params[attribute]
    end
end
