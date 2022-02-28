class ApplicationController < ActionController::Base
  include Pagy::Backend, SessionsHelper
  before_action :set_locale

  protect_from_forgery with: :exception

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
