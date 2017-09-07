class SessionsController < ApplicationController
  layout 'login_layout'
  def new; end

  def create
    user = Manager.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login_user user
      flash[:success] = "Welcome back #{user.manager_name.capitalize}!"
      redirect_to admin_dashboard_url
    else
      flash.now[:error] = 'Invalid user!'
      render :new
    end
  end

  def destroy
    logout_user
    render :new
  end
end
