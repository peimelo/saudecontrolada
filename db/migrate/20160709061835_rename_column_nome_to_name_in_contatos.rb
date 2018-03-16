class RenameColumnNomeToNameInContatos < ActiveRecord::Migration[5.1]
  def change
    rename_column :contatos, :nome, :name
  end
end
