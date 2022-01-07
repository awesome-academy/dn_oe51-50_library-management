class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :role
      t.string :name
      t.string :address
      t.string :email
      t.string :phone_number
      t.string :password
      t.string :city

      t.timestamps
    end
  end
end
