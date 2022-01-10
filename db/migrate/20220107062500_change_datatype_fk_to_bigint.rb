class ChangeDatatypeFkToBigint < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :category_id, :bigint
    change_column :book_authorships, :book_id, :bigint
    change_column :book_authorships, :author_id, :bigint
    change_column :loaned_details, :loaned_id, :bigint
    change_column :loaned_details, :book_id, :bigint
    change_column :loaned_books, :member_id, :bigint
  end
end
