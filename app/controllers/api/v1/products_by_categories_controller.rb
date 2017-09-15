module Api::V1
  class ProductsByCategoriesController < ApplicationController
    def show
      category = Category.find_by(slug: params[:id].downcase.strip)
      if category
        render json: Product.includes(:product_image).includes(:shop).joins(:category)
          .where('categories.id = :id OR categories.parent_id = :id', id: category.id).order('quantity_stock DESC, name'),
               each_serializer: Products::ListSerializer
      else
        render json: { message: 'Wrong category!', status: 400 }
      end
    end
  end
end
