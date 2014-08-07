class CreateValoresReferencias < ActiveRecord::Migration
  def change
    create_table :valores_referencias do |t|
      t.string :sexo, null: true
      t.integer :idade_inferior, null: true
      t.integer :idade_superior, null: true
      t.decimal :valor_inferior, precision: 6, scale: 2, null: false
      t.decimal :valor_superior, precision: 6, scale: 2, null: false
      
      t.references :exame, :null => false

      t.timestamps
    end

    add_foreign_key :valores_referencias, :exames      
  end
end
