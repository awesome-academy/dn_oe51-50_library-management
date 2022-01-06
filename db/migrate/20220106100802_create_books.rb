class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer :category_id
      t.string :book_title
      t.string :isbn
      t.date :year_published
      t.string :description
      t.integer :quantity
      t.string :publishing_house

      t.timestamps
    end
  end
end
