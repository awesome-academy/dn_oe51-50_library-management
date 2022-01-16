class LoanedBook < ApplicationRecord
  enum status: {rending: 0, returned: 1 , overdated: 2}

  belongs_to :user
  has_many :loaned_details, dependent: :destroy
  has_many :books, through: :loaned_details

  LOAN_ATS = %w(user_id date_loaned date_due quantity).freeze

  validates :user_id,
            presence: true

  validates :date_loaned,
            presence: true

  validates :date_due,
            presence: true

  validates :quantity,
            presence: true,
            numericality: {in: Settings.range.digit_1..Settings.range.digit_3}
end
