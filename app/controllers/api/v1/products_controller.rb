class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.includes(:product_image).all, each_serializer: Products::ListSerializer
  end

  def show
    render json: Product.includes(:product_images).find(params[:id]), serializer: Products::ShowSerializer
  end
end
