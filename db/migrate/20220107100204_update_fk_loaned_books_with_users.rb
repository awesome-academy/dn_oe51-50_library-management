class UpdateFkLoanedBooksWithUsers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :loaned_books, :users, column: :user_id
  end
end
