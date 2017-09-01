class Api::V1::CartsController < ApplicationController
  def show
    user = current_user_test
    if user
      render json: user.cart_detail
    else
      render json: { message: 'User not found!', status: 404 }
    end
  end

  def check_quantity(quantity)
    quantity.nil? || quantity.to_i < 0
  end

  def create
    user = current_user_test
    product = Product.find_by(id: params[:id])
    params[:quantity] = 1 if check_quantity(params[:quantity])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        message = cart.update(quantity: cart.quantity + params[:quantity].to_i)
        render json: { message: message, status: 200 }
      else
        cart = Cart.create!(user_id: user.id, product_id: product.id, quantity: params[:quantity].to_i)
        render json: { message: cart.errors.full_messages, status: 200 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end

  def update
    user = current_user_test
    product = Product.find_by(id: params[:id])
    params[:quantity] = 1 if check_quantity(params[:quantity])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        message = cart.update(quantity: cart.quantity + params[:quantity].to_i)
        render json: { message: message, status: 200 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end
end
