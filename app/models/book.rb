class Book < ApplicationRecord
  belongs_to :category
  has_many :loaned_details
  has_many :book_authorships, dependent: :destroy
  has_many :authors, through: :book_authorships
  has_many :loaned_books, through: :loaned_details

  scope :books_sort_asc_by_title, -> {order(book_title: :asc)}
  scope :newest, ->{order(created_at: :desc)}
end
