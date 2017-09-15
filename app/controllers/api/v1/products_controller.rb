class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.includes(:product_image).includes(:shop).order('quantity_stock DESC, name').all, each_serializer: Products::ListSerializer
  end

  def show
    render json: Product.includes(:product_images).find_by(slug: params[:id]), serializer: Products::ShowSerializer
  end
end
