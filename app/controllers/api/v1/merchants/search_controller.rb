class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.search(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  private
    def merchant_params
      params.permit(:name)
    end
end
