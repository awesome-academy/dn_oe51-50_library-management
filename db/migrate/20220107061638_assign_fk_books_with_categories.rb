class AssignFkBooksWithCategories < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :books, :categories, column: :category_id
  end
end
