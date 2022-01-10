class Book < ApplicationRecord
  belongs_to :category
  has_many :loaned_details
  has_many :book_authorships, dependent: :destroy
end
