class Admin::BaseController < ApplicationController
  before_action :check_admin

  private
  def check_admin; end
end
