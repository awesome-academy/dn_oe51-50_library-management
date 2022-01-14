class BooksController < ApplicationController
  before_action :find_book, except: :index

  def index
    @pagy, @books = pagy(Book.newest, items: Settings.pagy.digit_10)
  end

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
