class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :questioner_id, null: false
      t.integer :respondent_id, null: false
      t.integer :answer_id, null: false
      t.timestamps null: false
    end

    add_index :responses, [:questioner_id, :respondent_id]
    add_index :responses, :answer_id
  end
end
