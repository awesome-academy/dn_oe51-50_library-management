class LoanedDetail < ApplicationRecord
  include SessionsHelper

  before_create :set_pending
  after_create :change_book_quantity_down
  enum status: {rending: 0, returned: 1, overdated: 2, pending: 3, rejected: 4, closed: 5}

  belongs_to :book
  belongs_to :loaned_book

  private

  def change_book_quantity_down
    return if pending?

    book.update!(quantity: book.quantity - quantity)
  end

  def set_pending
    return unless current_user.member?

    self.status = LoanedDetail.statuses[:pending]
  end
end
