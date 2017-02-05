class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
    end

    add_index :meals, :name, unique: true
  end

end
