module Api::V1
  class OrdersController < ApplicationController
    def index
      user = current_user_test
      if user
        render json: UserOrder.where('user_id = :user', user: user.id), each_serializer: UserOrders::ListSerializer
      else
        render json: { messsage: 'User not found!', status: 401 }
      end
    end

    def create
      user = current_user_test
      if user
        carts = user.carts
        if carts.empty?
          render json: { messsage: 'Your cart is empty!', status: 400 }
        elsif check_quantity_stock(carts)
          total = user.product_in_carts.sum('products.price * quantity')
          user_order = UserOrder.create(user_id: user.id,        receiver_name: user.first_name,
                                        address: user.address,   phone: user.phone,
                                        province: user.province, total: total)
          make_order(carts, user_order.id)
          carts.clear
          render json: { messsage: 'Order success!', order_id: user_order.id, status: 200 }
        else
          render json: { messsage: 'Out of order!', status: 400 }
        end
      else
        render json: { messsage: 'User not found!', status: 401 }
      end
    end

    def show
      user = current_user_test
      if user
        render json: user.orders.where('user_orders.id = :id', id: params[:id]), each_serializer: Orders::DetailSerializer
      else
        render json: { messsage: 'User not found!', status: 401 }
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
        Order.create(user_order_id: user_order_id,
                     product_id: cart.product_id,
                     quantity: cart.quantity,
                     price: cart.product.price)
      end
    end
  end
end
