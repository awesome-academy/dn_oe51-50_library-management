class CartsController < ApplicationController
  include SessionsHelper, CartsHelper

  before_action :logged_in_user, :check_valid_user
  before_action :find_book, :check_quantity_add, only: :create

  def index
    @carts = get_all_item_in_cart
  end

  def create
    item = find_book_in_cart @book
    if item
      item[@book.id] += params[:quantity].to_i
    else
      current_cart.merge! @book.id => params[:quantity].to_i
    end
    session[:cart] = current_cart
    flash[:success] = t "notice.add_cart_success"
    redirect_to book_path(@book)
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash.now[:danger] = t "error.not_found_book"
    redirect_to home_path
  end

  def check_quantity_add
    @quantity = total_loan_books
    temp_total_loan = @quantity + User.get_total_loaned_books(current_user)
    return if temp_total_loan <= Settings.limit_loans.maximum

    quantity_valid params[:quantity].to_i
    redirect_to book_path(@book)
  end

  def quantity_valid quantity
    flash[:danger] = if quantity.negative? ||
                        quantity.zero?
                       t "error.quantity.not_valid"
                      else
                        t "error.quantity.over"
                      end
  end
end
