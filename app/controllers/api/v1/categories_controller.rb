module Api::V1
  class CategoriesController < ApplicationController
    before_action :take_category, only: %i[show update destroy]

    def index
      # @category_now
      # update_category_now
      render json: Category.where(parent_id: nil), each_serializer: Categories::ShowSerializer
    end

    def show
      if !@category.nil?
        render json: @category, serializer: Categories::CategoriesSerializer
      else
        render json: { message: 'Cannot found!', status: 404 }
      end
    end

    def create
      category = Categories.new(category_params)
      if category.save
        render json: { message: 'Success!', status: 200 }
      else
        render json: { message: 'False!', status: 409 }
      end
    end

    def update
      message = if @category
                  if @category.update(category_params)
                    { message: 'Update successed!', status: 202 }
                  else
                    { message: 'Update failt!', status: 409 }
                  end
                else
                  { message: 'Not found user!', status: 404 }
                end
      message['errors'] = @category.errors.full_messages
      render json: message
    end

    def destroy
      if @category.destroy
        render json: { message: 'Success!', status: 200 }
      else
        render json: { message: 'False!', status: 409 }
      end
    end

    private

    def update_category_now
      @category_now = render json: Category.where(parent_id: nil), each_serializer: Categories::ShowSerializer
      binding.pry
    end

    def take_category
      @category = Category.find_by(params[:id])
    end

    def category_params
      params.permit(:name)
    end
  end
end
