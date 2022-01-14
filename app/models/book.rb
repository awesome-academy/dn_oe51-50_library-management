class Book < ApplicationRecord
  belongs_to :category
  has_many :loaned_details
  has_many :book_authorships, dependent: :destroy
  has_many :authors, through: :book_authorships
  scope :newest, ->{order(created_at: :desc)}
end
