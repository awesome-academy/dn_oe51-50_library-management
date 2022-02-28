class User < ApplicationRecord
  enum role: {admin: 0, member: 1, guest: 2}

  has_many :loaned_books
  has_many :loaned_details, through: :loaned_books

  validates_presence_of :role, :name, :address, :email, :phone_number, :password, :city

  devise :database_authenticatable, :validatable

  class << self
    def is_valid_member? user
      exists? id: user, role: User.roles[:member]
    end

    def get_total_loaned_books user
      sum_loaned_book = 0
      user.loaned_details.each do |item|
        sum_loaned_book += item.quantity
      end
      sum_loaned_book.to_i
    end
  end
end
