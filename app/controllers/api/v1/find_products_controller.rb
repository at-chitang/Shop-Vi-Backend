module Api::V1
  class FindProductsController < ApplicationController
    def show
      if params[:id]
        s = params[:id].downcase.gsub(/\s+/, '%').strip
        s = "%#{s}%"
        products = Product.where('lower(name) like :key', key: s)
        if products.empty?
          render json: { message: 'No product match!', status: 404 }
        else
          render json: products, each_serializer: Products::ListSerializer
        end
      else
        render json: { message: 'Not thing!', status: 400 }
      end
    end
  end
end
