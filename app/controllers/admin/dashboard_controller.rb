# Dashboard
class Admin::DashboardController < ApplicationController
  def new
    unless current_user.present?
      flash[:danger] = 'You must login first!'
      redirect_to admin_login_url
    end
    @total_user = User.count
    @total_comment = Comment.count
    @total_order = Order.count
    @total_member = User.count
  end
end
