class Admin::BooksController < Admin::BaseController
  before_action :find_book, except: :index

  def show
    @authors = @book.authors
  end

  private

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "error.not_found_book"
    redirect_to home_path
  end
end
