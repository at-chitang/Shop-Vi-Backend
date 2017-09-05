class Api::V1::OrdersController < ApplicationController
  def create
    user = current_user_test
    if user
      carts = user.carts
      binding.pry
    else
      puts 'xui te'
    end
  end
end
