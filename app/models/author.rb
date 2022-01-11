class Author < ApplicationRecord
  has_many :book_authorships
  has_many :books, through: :book_authorships
end
