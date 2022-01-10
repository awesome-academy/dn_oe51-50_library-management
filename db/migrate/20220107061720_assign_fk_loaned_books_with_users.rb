class AssignFkLoanedBooksWithUsers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :loaned_books, :users, column: :member_id
  end
end
