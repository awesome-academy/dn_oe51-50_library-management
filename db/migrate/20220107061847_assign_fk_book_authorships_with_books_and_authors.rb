class AssignFkBookAuthorshipsWithBooksAndAuthors < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :book_authorships, :books, column: :book_id
    add_foreign_key :book_authorships, :authors, column: :author_id
  end
end
