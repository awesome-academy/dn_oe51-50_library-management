class ChangeNameLoanedIdTbLoanedDetail < ActiveRecord::Migration[6.0]
  def change
    rename_column :loaned_details, :loaned_id, :loaned_book_id
  end
end
