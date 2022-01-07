class LoanedBook < ApplicationRecord
  enum status: {rending: 0, returned: 1 , overdated: 2}
end
