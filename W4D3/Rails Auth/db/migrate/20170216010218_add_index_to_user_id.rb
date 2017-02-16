class AddIndexToUserId < ActiveRecord::Migration
  def change
    add_index :cats, :user_id, unique: true
  end
end
