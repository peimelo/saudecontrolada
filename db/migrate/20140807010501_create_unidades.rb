class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
      t.string :nome, null: false

      t.timestamps null: false
    end

    add_index :unidades, :nome, unique: true
  end
end
