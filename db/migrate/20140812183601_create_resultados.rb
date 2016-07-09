class CreateResultados < ActiveRecord::Migration
  def change
    create_table :resultados do |t|
      t.datetime :data, null: false
      t.decimal :valor, precision: 6, scale: 2

      t.references :exame, null: false
      t.references :user, null: false

      t.timestamps null: false
    end

    add_foreign_key :resultados, :exames
    add_foreign_key :resultados, :users
  end
end
