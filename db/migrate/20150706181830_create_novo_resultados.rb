class CreateNovoResultados < ActiveRecord::Migration[5.1]
  def change
    create_table :resultados do |t|
      t.date :data, null: false
      t.string :descricao, null: false

      t.references :user, null: false

      t.timestamps null: false
    end

    add_foreign_key :resultados, :users
  end
end
