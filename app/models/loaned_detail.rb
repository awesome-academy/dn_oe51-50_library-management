class LoanedDetail < ApplicationRecord
  after_create :change_book_quantity_down
  enum status: {rending: 0, returned: 1, overdated: 2, pending: 3, rejected: 4, closed: 5}

  belongs_to :book
  belongs_to :loaned_book

  private

  def change_book_quantity_down
    return if pending?

    book.update!(quantity: book.quantity - quantity)
  end
end
