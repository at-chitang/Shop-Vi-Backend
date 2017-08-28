class Api::V1::ShopsController < ApplicationController
  def index
    render json: Shop.all
  end

  def create
    Shop.new(params_shop)
  end

  private

  def params_shop
    params.permit(:name, :logo, :phone, :address, :status)
  end
end
