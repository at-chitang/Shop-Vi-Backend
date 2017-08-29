module Api::V1
  class FindProductsController < ApplicationController
    def show
      s = params[:id].downcase!
      s = s.split('')
      s.each_index { |i| s[i] = '_' if 'aueoi'.include? s[i] }
      s = s.join
      sa = s.split(' ')
      s2 = []
      sa.each { |i| s2 << s.gsub(/ /, '%').gsub(i, '%') }
      product = []
      s2.each do |i|
        product << Product.where('name LIKE ?', i)
      end
      binding.pry
      if product.size > 0
        render json: product, each_serializer: Products::ListSerializer
      else
        render json: { message: 'No product match!', status: 400 }
      end
    end
  end
end
