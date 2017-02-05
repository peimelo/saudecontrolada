class CreateAlimentation < ActiveRecord::Migration[5.0]
  def change
    create_table :alimentations do |t|
      t.datetime :date, null: false
      t.references :user, null: false
      t.references :meal, null: false

      t.timestamps null: false
    end

    add_foreign_key :alimentations, :users
    add_foreign_key :alimentations, :meals

    add_index :alimentations, [:date, :user_id], unique: true
  end
end
