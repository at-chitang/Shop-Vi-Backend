class Admin::ProfilesController < ApplicationController
  def show; end

  def edit; end

  def update
    if current_user.update(manager_params)
      flash[:success] = 'Your profile was update success!'
      redirect_to :show
    else
      flash[:warning] = 'Something wrong!'
      render :edit
    end
  end

  private

  def manager_params
    params[:manager].permit :manager_name, :gender, :phone, :address
  end

  def init_manager; end
end
