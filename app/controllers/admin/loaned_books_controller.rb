class Admin::LoanedBooksController < Admin::BaseController
  before_action :check_valid_user,
    :find_book,
    :assign_new_loan,
    :check_quantity_add,
    :create_loan_detail, only: :create

  def new
    @loaned_book = LoanedBook.new
  end

  def create
    ActiveRecord::Base.transaction do
      @loaned_book.save!
    end
    flash[:info] = t "notice.create_loan_success"
    redirect_to home_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t "error.create_loan_failure"
    render :new
  end

  private

  def assign_new_loan
    @loaned_book = @user.loaned_books.build loaned_book_params
  end

  def find_book
    @book = Book.find_by id: params.dig(:loaned_book, :book_id)
    return if @book

    flash.now[:danger] = t "error.not_found_book"
    render :new
  end

  def loaned_book_params
    params.require(:loaned_book)
          .permit(LoanedBook::LOAN_ATS)
  end

  def create_loan_detail
    @loaned_book.loaned_details.build(
      book_id: @book.id,
      quantity: @quantity
    )
  end

  def check_quantity_add
    @quantity = params.dig(:loaned_book, :quantity).to_i
    temp_total_loan = @quantity + User.get_total_loaned_books(@user)
    return if @quantity <= @book.quantity &&
              temp_total_loan <= Settings.limit_loans.maximum

    quantity_valid @quantity
    render :new
  end

  def quantity_valid quantity
    flash[:danger] =  if quantity.negative? ||
                        quantity.zero?
                        t "error.quantity.not_valid"
                      else
                        t "error.quantity.over"
                      end
  end

  def check_valid_user
    @user = User.find_by id: params.dig(:loaned_book, :user_id)
    return if User.is_valid_member? @user

    flash.now[:danger] = t "error.user_invalid"
    render :new
  end
end
