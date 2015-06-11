class CreateErros < ActiveRecord::Migration
  def up
    create_table :erros do |t|
      t.string     :nome
      t.text       :descricao
      t.references :user, :null => true
      t.string     :ip
      t.references :recurso, :null => false
      t.text       :resolucao
      t.references :erro_status, :null => false, :default => 1
      t.string     :dispositivo
      t.references :condo, :null => true

      t.timestamps
    end

    add_foreign_key :erros, :recursos
    add_foreign_key :erros, :erros_status
    add_foreign_key :erros, :users
  end

  def down
    drop_table :erros
  end
end
