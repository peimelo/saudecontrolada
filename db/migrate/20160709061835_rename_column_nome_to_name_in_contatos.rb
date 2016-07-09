class RenameColumnNomeToNameInContatos < ActiveRecord::Migration[5.0]
  def change
    rename_column :contatos, :nome, :name
  end
end
