class AddDefaultValueToStatusAndRole < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role, :integer, default: 2
    change_column :loaned_books, :status, :integer, default: 0
    change_column :loaned_details, :status, :integer, default: 0
  end
end
