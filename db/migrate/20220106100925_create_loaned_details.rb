class CreateLoanedDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :loaned_details do |t|
      t.integer :loaned_id
      t.integer :book_id
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
  end
end
