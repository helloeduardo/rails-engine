class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue
    render json: RevenueSerializer.revenue(revenue)
  end
end
