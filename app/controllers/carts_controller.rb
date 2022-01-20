class CartsController < ApplicationController
  include SessionsHelper, CartsHelper

  before_action :logged_in_user, :check_valid_user
  before_action :find_book, only: :create

  def index
    @carts = get_all_item_in_cart
  end

  def create
    item = find_book_in_cart @book

    check_quantity_add item
    redirect_to book_path(@book)
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash.now[:danger] = t "error.not_found_book"
    redirect_to home_path
  end

  def check_quantity_add item
    params_qt = params[:quantity].to_i
    @quantity = total_loan_books + params_qt
    temp_total_loan = @quantity + User.get_total_loaned_books(current_user)

    if params_qt.negative? || params_qt.zero?
      flash[:danger] = t "error.quantity.not_valid"
    elsif temp_total_loan > Settings.limit_loans.maximum
      flash[:danger] = t "error.quantity.over"
    else
      if item
        current_cart[@book.id.to_s] += params[:quantity].to_i
      else
        current_cart.merge! @book.id => params[:quantity].to_i
      end
      session[:cart] = current_cart
      flash[:success] = t "notice.add_cart_success"
    end
  end
end
