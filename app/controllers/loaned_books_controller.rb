class LoanedBooksController < ApplicationController
  include SessionsHelper, CartsHelper

  before_action :logged_in_user, :check_valid_user
  before_action :load_cart, :check_quantity_add, :assign_new_loan, :create_loan_detail, only: :create

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
    @carts.each do |item|
      @loaned_book.loaned_details.build(
        book_id: item[:book].id,
        quantity: item[:quantity]
      )
    end
  end

  def load_cart
    @carts = get_all_item_in_cart
    return if @carts

    flash[:info] = t "notice.nothing_in_cart"
    redirect_to home_path
  end

  def assign_new_loan
    @loaned_book = current_user.loaned_books.build(
      date_loaned: Time.now,
      date_due: Time.now + Settings.df_date_due.days,
      quantity: @quantity
    )
  end

  def check_quantity_add
    @quantity = total_loan_books
    temp_total_loan = @quantity + User.get_total_loaned_books(current_user)
    return if temp_total_loan <= Settings.limit_loans.maximum

    quantity_valid @quantity
    render :new
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
