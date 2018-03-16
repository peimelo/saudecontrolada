class RenameColumnNomeToNameInExames < ActiveRecord::Migration[5.1]
  def change
    rename_column :exames, :nome, :name
  end
end
