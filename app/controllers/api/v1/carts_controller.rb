module Api::V1
  class CartsController < ApplicationController
    # before_action :check_user_prduct, only: %i[create update destroy]

    def count
      user = current_user_test
      if user
        render json: { amount: user.carts.sum(:quantity), status: 200 }
      else
        render json: { message: 'User not found!', status: 404 }
      end
    end

    def show
      user = current_user_test
      if user
        render json: user.carts.includes(:product_image).includes(:shop), each_serializer: Carts::ShowSerializer
      else
        render json: { message: 'User not found!', status: 404 }
      end
    end

    def create
      if check_user_prduct
        # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
        # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
        cart = @user.carts.find_by(product_id: @product.id)

        if cart
          if check_quantity(@product.quantity_stock, params[:quantity] ||= (1 + cart.quantity), cart.quantity)
            message = cart.update(quantity: params[:quantity].to_i)
            render json: { message: message, status: 200 }
          else
            render json: { message: 'Wrong quantity!', status: 405 }
          end
        else
          quantity = check_quantity(@product.quantity_stock, params[:quantity])
          cart = Cart.create!(user_id: @user.id, product_id: @product.id, quantity: quantity)
          render json: { message: cart.errors.full_messages[0], status: 200 }
        end
      else
        render json: { message: 'Connect denied!', status: 400 }
      end
    end

    def update
      if check_user_prduct
        # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
        # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
        cart = @user.carts.find_by(product_id: @product.id)
        if cart && check_quantity(@product.quantity_stock, params[:quantity], cart.quantity)
          quantity = check_quantity(@product.quantity_stock, params[:quantity], cart.quantity)
          message = cart.update(quantity: quantity)
          render json: { message: message, status: 200 }
        else
          render json: { message: 'Connect denied!', status: 400 }
        end
      else
        render json: { message: 'Not found!', status: 404 }
      end
    end

    def destroy
      if check_user_prduct
        # cart = user.carts.joins(:product).find_by('products.slug' => params[:slug])
        # cart = user.carts.joins(:product).find_by('products.id' => params[:id])
        cart = @user.carts.find_by(product_id: @product.id)
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

    private

    def check_quantity(shop_quantity, new_quantity = 1, old_quantity = 0)
      new_quantity ||= 1
      if new_quantity.nil? || new_quantity.to_i < 0 || new_quantity.to_i > shop_quantity || new_quantity.to_i == old_quantity
        nil
      else
        new_quantity
      end
    end

    def check_user_prduct
      @user = current_user_test
      @product = Product.find_by(slug: params[:slug])
      !(@user.nil? || @product.nil?)
    end
  end
end
