class CreateRecursos < ActiveRecord::Migration
  def up
    create_table :recursos do |t|
      t.references :acao, :null => false
      t.references :controlador, :null => false
      t.string :nome, :null => false
      t.boolean :visivel, :null => false, :default => false
      t.references :recurso_categoria, :null => false

      t.timestamps null: false
    end

    add_index :recursos, [:acao_id, :controlador_id], :unique => true
    add_index :recursos, :nome, :unique => true

    add_foreign_key :recursos, :acoes
    add_foreign_key :recursos, :controladores
    add_foreign_key :recursos, :recursos_categorias
  end

  def down
    drop_table :recursos
  end
end
