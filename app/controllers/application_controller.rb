class ApplicationController < ActionController::Base
  include Pagy::Backend, SessionsHelper
  before_action :set_locale

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "notice.please_log_in"
    redirect_to login_url
  end

  def check_valid_user
    return if current_user.member?

    flash.now[:danger] = t "error.user_invalid"
    redirect_to home_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
