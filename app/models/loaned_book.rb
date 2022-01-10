class LoanedBook < ApplicationRecord
  enum status: {rending: 0, returned: 1 , overdated: 2}

  belongs_to :user
  has_many :loaned_details, dependent: :destroy
end
