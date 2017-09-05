class Api::V1::CartsController < ApplicationController
  def show
    user = current_user_test
    if user
      render json: user.cart_detail
    else
      render json: { message: 'User not found!', status: 404 }
    end
  end

  def check_quantity(new_quantity, old_quantity, shop_quantity)
    new_quantity.nil? || new_quantity.to_i < 0 || new_quantity.to_i > shop_quantity ? old_quantity : new_quantity.to_i
  end

  def create
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        quantity = check_quantity(params[:quantity], cart.quantity, product.quantity_stock)
        message = cart.update(quantity: quantity)
        render json: { message: message, status: 200 }
      else
        quantity = check_quantity(params[:quantity], 0, product.quantity_stock)
        cart = Cart.create!(user_id: user.id, product_id: product.id, quantity: quantity)
        render json: { message: cart.errors.full_messages, status: 200 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end

  def update
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        quantity = check_quantity(params[:quantity], cart.quantity, product.quantity_stock)
        message = cart.update(quantity: quantity)
        render json: { message: message, status: 200 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end

  def destroy
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        message = cart.delete
        render json: { message: message, status: 200 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end
end
