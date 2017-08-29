class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.all, each_serializer: Products::ListSerializer
  end

  def show
    render json: Product.find(params[:id]), serializer: Products::ShowSerializer
  end
end
