class BookAuthorship < ApplicationRecord
  belongs_to :book
  belongs_to :author
end
