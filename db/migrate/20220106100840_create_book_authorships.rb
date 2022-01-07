class CreateBookAuthorships < ActiveRecord::Migration[6.0]
  def change
    create_table :book_authorships do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
  end
end
