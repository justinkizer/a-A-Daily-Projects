class CreateGoalComments < ActiveRecord::Migration[5.0]
  def change
    create_table :goal_comments do |t|
      t.integer :goal_id
      t.text :content

      t.timestamps
    end
  end
end
