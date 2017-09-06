# Dashboard
class Admin::DashboardController < ApplicationController
  def new
    unless current_user.present?
      flash[:danger] = 'You must login first!'
      redirect_to admin_login_url
    end
    @total_user = User.all.size
    @total_comment = Comment.all.size
    @total_order = Order.all.size
    @total_member = User.all.size
  end
end
