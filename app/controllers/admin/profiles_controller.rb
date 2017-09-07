class Admin::ProfilesController < ApplicationController
  before_action :set_manager

  def show; end

  def edit; end

  def update
    if @user && @user.update(manager_params)
      flash.now[:success] = 'Your profile was update success!'
      render :show
    else
      flash.now[:warning] = 'Something wrong!'
      render :edit
    end
  end

  private

  def set_manager
    @user = current_user if logged_in?
  end

  def manager_params
    params.require(:manager).permit :manager_name, :gender, :phone, :address, :avatar, :avatar_cache
  end
end
