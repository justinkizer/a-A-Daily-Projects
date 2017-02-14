class UpdateUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :name, :email
      t.string :username, null: false

   end
    add_index :users, :username, unique: true
  end
end
