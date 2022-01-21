class Admin::BaseController < ApplicationController
  before_action :check_admin

  private
  def check_admin
    return if @current_user.admin?

    flash[:danger] = t "error.forbiden"
    redirect_to root_path
  end
end
