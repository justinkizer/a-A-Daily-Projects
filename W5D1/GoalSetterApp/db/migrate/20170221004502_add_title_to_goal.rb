class AddTitleToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :title, :string
  end
end
