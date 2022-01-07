class LoanedDetail < ApplicationRecord
  enum status: {rending: 0, returned: 1 , overdated: 2}

  belongs_to :book
  belongs_to :loaned_book
end
