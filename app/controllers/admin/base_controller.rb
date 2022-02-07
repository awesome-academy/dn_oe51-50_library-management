class Admin::BaseController < ApplicationController
  before_action :load_user, :check_admin

  private
  def check_admin
    return if current_user.admin?

    flash[:danger] = t "error.forbiden"
    redirect_to root_path
  end

  def load_user
    return if logged_in?

    flash[:danger] = t "notice.please_log_in"
    redirect_to root_path
  end
end
