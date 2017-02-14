class RemoveUniquenessFromContacts < ActiveRecord::Migration
  remove_index :contacts, :user_id
  add_index :contacts, :user_id
end
