class LoanedDetail < ApplicationRecord
  after_create :change_book_quantity_down
  enum status: {rending: 0, returned: 1 , overdated: 2}

  belongs_to :book
  belongs_to :loaned_book

  private

  def change_book_quantity_down
    book.update!(quantity: book.quantity - quantity)
  end
end
