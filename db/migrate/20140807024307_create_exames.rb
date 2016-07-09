class CreateExames < ActiveRecord::Migration
  def change
    create_table :exames do |t|
      t.string :nome, null: false

      t.references :unidade, null: true

      t.timestamps null: false
    end

    add_index :exames, :nome, unique: true
    add_foreign_key :exames, :unidades
  end
end