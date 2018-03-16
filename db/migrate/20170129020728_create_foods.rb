class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.string :measure, null: false
      t.decimal :amount, precision: 5, scale: 2
      t.decimal :cho, precision: 5, scale: 2, null: false
      t.decimal :kcal, precision: 6, scale: 2, null: false
    end

    add_index(:foods, [:name, :measure], unique: true)
  end
end
