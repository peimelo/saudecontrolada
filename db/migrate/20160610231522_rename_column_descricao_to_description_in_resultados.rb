class RenameColumnDescricaoToDescriptionInResultados < ActiveRecord::Migration[5.1]
  def change
    rename_column :resultados, :descricao, :description
  end
end
