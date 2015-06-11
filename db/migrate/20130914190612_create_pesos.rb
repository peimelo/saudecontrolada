class CreatePesos < ActiveRecord::Migration
  def change
    create_table :pesos do |t|
      t.datetime :data, null: false
      t.decimal :peso, precision: 5, scale: 2, null: false
      t.decimal :altura, precision: 3, scale: 2, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_foreign_key :pesos, :users
  end
end
