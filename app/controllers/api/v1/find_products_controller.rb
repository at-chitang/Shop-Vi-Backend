module Api::V1
  class FindProductsController < ApplicationController
    def show
      if params[:id]
        s = params[:id].downcase.gsub(/\s+/, '%').strip
        s = "%#{s}%"
        products = Product.where('lower(name) like :key', key: s)
        if products.empty?
          render json: products, each_serializer: Products::ListSerializer
        else
          render json: { message: 'No product match!', status: 400 }
        end
      else
        message
      end
    end
  end
end
