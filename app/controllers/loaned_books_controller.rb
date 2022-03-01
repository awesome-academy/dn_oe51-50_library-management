class LoanedBooksController < ApplicationController
  include SessionsHelper, CartsHelper

  before_action :authenticate_user!, :check_valid_user
  before_action :load_cart, :check_quantity_add, :assign_new_loan, :create_loan_detail, only: :create
  authorize_resource

  def index
    @pagy, @loaned_books= pagy current_user.loaned_books.newest, items: Settings.pagy.digit_10
  end

  def create
    ActiveRecord::Base.transaction do
      @loaned_book.save!
    end
    flash[:info] = t "notice.create_loan_success"
    redirect_to loaned_books_path
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "error.create_loan_failure"
    redirect_to home_path
  end

  private

  def create_loan_detail
    @carts.each do |book, quantity|
      @loaned_book.loaned_details.build(
        book_id: book.id,
        quantity: quantity,
        status: LoanedDetail.statuses[:pending]
      )
    end
  end

  def load_cart
    @carts = get_all_item_in_cart
  end

  def assign_new_loan
    @loaned_book = current_user.loaned_books.build(
      date_loaned: Time.now,
      date_due: Time.now + Settings.df_date_due.days,
      quantity: @quantity,
      status: LoanedBook.statuses[:pending]
    )
  end

  def check_quantity_add
    @quantity = total_loan_books

    check_params_quantity_valid
    check_stock_quantity_valid
  end

  def check_params_quantity_valid
    return unless @quantity.negative? || @quantity.zero?

    flash[:danger] = t "error.quantity.not_valid"
    redirect_to carts_path
  end

  def check_stock_quantity_valid
    temp_total_loan = @quantity + User.get_total_loaned_books(current_user)
    return unless temp_total_loan > Settings.limit_loans.maximum

    flash[:danger] = t "error.quantity.over"
    redirect_to carts_path
  end
end
