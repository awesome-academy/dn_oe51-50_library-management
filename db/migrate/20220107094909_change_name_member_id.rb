class ChangeNameMemberId < ActiveRecord::Migration[6.0]
  def change
    rename_column :loaned_books, :member_id, :user_id
  end
end
