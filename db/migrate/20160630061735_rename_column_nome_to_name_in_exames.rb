class RenameColumnNomeToNameInExames < ActiveRecord::Migration[5.0]
  def change
    rename_column :exames, :nome, :name
  end
end
