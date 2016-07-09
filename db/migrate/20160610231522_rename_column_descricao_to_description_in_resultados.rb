class RenameColumnDescricaoToDescriptionInResultados < ActiveRecord::Migration[5.0]
  def change
    rename_column :resultados, :descricao, :description
  end
end
