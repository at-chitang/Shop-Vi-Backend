class Admin::SessionsController < ApplicationController
  layout 'login_layout'

  def new; end

  def create
    binding.pry
    @user = Manager.find_by email: params[:session][:email]
    if @user && @user.authenticate(params[:session][:password])
      login_user(@user)
      binding.pry
      # render dashbord_url
    else
      flash.now[:error] = 'Invalid account!'
      render :new
    end
  end

  def destroy; end
end
