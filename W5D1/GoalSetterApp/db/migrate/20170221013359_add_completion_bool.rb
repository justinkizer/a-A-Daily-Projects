class AddCompletionBool < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :completed?, :boolean, default: false
  end
end
