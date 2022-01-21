class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:danger] = t "flash.danger"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      login_in @user
      flash[:info] = t "email.check_activate"
      redirect_to root_url
    else
      render :new
    end
  end
end
