class CreateValores < ActiveRecord::Migration
  def change
    create_table :valores do |t|
      t.string :sexo, null: true
      t.decimal :idade_inferior, precision: 6, scale: 3, null: true
      t.decimal :idade_superior, precision: 6, scale: 3, null: true
      t.decimal :valor_inferior, precision: 6, scale: 2, null: true
      t.decimal :valor_superior, precision: 6, scale: 2, null: true
      
      t.references :exame, null: false
      t.references :referencia, null: true

      t.timestamps
    end

    add_foreign_key :valores, :exames
    add_foreign_key :valores, :referencias
  end
end
