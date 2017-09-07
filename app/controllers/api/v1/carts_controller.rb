class Api::V1::CartsController < ApplicationController
  def show
    user = current_user_test
    if user
      render json: user.cart_detail
    else
      render json: { message: 'User not found!', status: 404 }
    end
  end

  def check_quantity(new_quantity, shop_quantity, old_quantity = 0)
    new_quantity.nil? || new_quantity.to_i < 0 || new_quantity.to_i > shop_quantity || new_quantity == old_quantity
  end

  def create
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if check_quantity(params[:quantity], product.quantity_stock, cart.quantity || 0)
        if cart
          message = cart.update(quantity: params[:quantity].to_i)
          render json: { message: message, status: 200 }
        else
          cart = Cart.create!(user_id: user.id, product_id: product.id, quantity: params[:quantity].to_i)
          render json: { message: cart.errors.full_messages[0], status: 200 }
        end
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end

  def update
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart && true
        quantity = check_quantity(params[:quantity], cart.quantity, product.quantity_stock)
        message = cart.update(quantity: quantity)
        render json: { message: message, status: 200 }
      else
        render json: { message: 'Connect denied!', status: 400 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end

  def destroy
    user = current_user_test
    product = Product.find_by(slug: params[:slug])
    if user && product
      # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
      # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
      cart = user.carts.find_by(product_id: product.id)
      if cart
        message = cart.delete
        render json: { message: message, status: 200 }
      else
        render json: { message: 'Connect denied!', status: 400 }
      end
    else
      render json: { message: 'Connect denied!', status: 400 }
    end
  end
end
