module Api::V1
  class ProductsByCategoriesController < ApplicationController
    def show
      category = Category.find_by(slug: params[:id].downcase.strip)
      if category
        list_product = category.products
        category.children.each do |i|
          list_product << i.products
        end
        render json: list_product
      else
        render json: { message: 'Wrong category!', status: 400 }
      end
    end
  end
end
