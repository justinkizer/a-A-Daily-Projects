class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, limit: 1, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
    add_index(:cats, [:name, :birth_date], unique: true)
    add_index(:cats, :name)
  end
end
