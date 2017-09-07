module Api::V1
  class ShopsController < ApplicationController
    def index
      render json: Shop.all
    end

    def create
      shop = Shop.new(params_create_shop)
      message = if shop.valid?
                  manager = Manager.new(params_create_main_manager)
                  manager['role'] = 1
                  manager['shop_id'] = 1
                  if manager.valid?
                    shop.save
                    shop = Shop.find_by(shop_name: shop.shop_name)
                    manager['shop_id'] = shop.id
                    manager.save
                    { message: 'Create shop succeed!' }
                  else
                    { message: 'Wrong manager valid!' }
                  end
                else
                  { message: 'Wrong shop valid!' }
                end
      render json: message
    end

    private

    def params_create_shop
      params.permit(:shop_name, :phone, :address, :logo)
    end

    def params_create_main_manager
      params.permit(:manager_name, :phone, :password, :password_confirmation)
    end

    def manager_shop
      params.permit(:password, :password_confirmation, :shop_id)
    end
  end
end
