class CreateLoanedBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :loaned_books do |t|
      t.integer :member_id
      t.datetime :date_loaned
      t.datetime :date_due
      t.datetime :date_returned
      t.float :overdue_fee
      t.integer :status
      t.integer :quantity

      t.timestamps
    end
  end
end
