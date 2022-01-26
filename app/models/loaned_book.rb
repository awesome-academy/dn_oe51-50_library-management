class LoanedBook < ApplicationRecord
  include SessionsHelper

  before_create :set_pending
  enum status: {rending: 0, returned: 1, overdated: 2, pending: 3, rejected: 4, closed: 5}

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

  private

  def set_pending
    return unless current_user.member?

    self.status = LoanedBook.statuses[:pending]
  end
end
