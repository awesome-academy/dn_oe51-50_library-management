class AssignFkLoanedDetailsWithBooksAndLoaned < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :loaned_details, :books, column: :book_id
    add_foreign_key :loaned_details, :loaned_books, column: :loaned_id
  end
end
