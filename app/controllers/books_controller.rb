class BooksController < ApplicationController
  before_action :find_book, except: :index
  authorize_resource

  def index
    books = Book.search_by_tilte(params[:term]).newest
    @pagy, @books = pagy books, items: Settings.pagy.digit_10
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
