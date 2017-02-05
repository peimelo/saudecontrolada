class CreateAlimentationsFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :alimentations_foods do |t|
      t.decimal  :value, null: false, precision: 6, scale: 2
      t.references :alimentation, null: false
      t.references :food, null: false

      t.timestamps null: false
    end

    add_foreign_key :alimentations_foods, :alimentations
    add_foreign_key :alimentations_foods, :foods

    add_index :alimentations_foods, [:alimentation_id, :food_id],
              unique: true
  end
end
