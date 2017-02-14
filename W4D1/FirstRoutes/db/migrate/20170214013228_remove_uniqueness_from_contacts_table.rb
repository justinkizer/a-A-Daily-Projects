class RemoveUniquenessFromContactsTable < ActiveRecord::Migration
  remove_index :contact_shares, [:contact_id, :user_id]
  remove_index :contact_shares, :user_id
  add_index :contact_shares, :contact_id
  add_index :contact_shares, :user_id
end
