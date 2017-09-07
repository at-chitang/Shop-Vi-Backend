class Api::V1::OrdersController < ApplicationController
  def create
    user = current_user_test
    if user
      carts = user.carts
      if carts.empty?
        render json: { messsage: 'Your cart is empty!', status: 400 }
      elsif check_quantity_stock(carts)
        user_order = UserOrder.create(user_id: user.id)
        make_order(carts, user_order.id)
        # carts.clear
        render json: { messsage: 'Order success!', status: 200 }
      else
        render json: { messsage: 'Out of order!', status: 400 }
      end
    else
      render json: { messsage: 'xui te', status: 400 }
    end
  end

  private

  def check_quantity_stock(carts)
    result = true
    Product.transaction do
      carts.each do |cart|
        product = cart.product
        unless product.update_attributes(quantity_stock: product.quantity_stock - cart.quantity)
          result = false
          raise ActiveRecord::Rollback
        end
      end
    end
    result
  end

  def make_order(carts, user_order_id)
    carts.each do |cart|
      Order.create(userorder_id: user_order_id,
                   product_id: cart.product_id,
                   quantity: cart.quantity)
    end
  end
end
