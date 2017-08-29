class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.all, each_serializer: Product::ListSerializer
  end

  def show
    render json: Product.find(params[:id]), serializer: Product::ShowSerializer
  end
end
