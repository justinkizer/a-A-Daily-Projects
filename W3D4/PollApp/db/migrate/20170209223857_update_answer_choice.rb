class UpdateAnswerChoice < ActiveRecord::Migration
  def change

    change_column :answer_choices, :text, :text, null: false 
  end
end
