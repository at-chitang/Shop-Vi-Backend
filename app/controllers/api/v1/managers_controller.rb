module Api::V1
  class ManagersController < ApplicationController
    def index
      render json: Manager.all
    end

    def create
      manager = Managers.new(manager_create_params)
      render json: manager
    end

    private

    def manager_create_params
      params.permit(:shopname, :password, :password_confirm, :role, :manager, :shop)
    end

    def manager_update_params
      params.permit(:managername)
    end
  end
end
