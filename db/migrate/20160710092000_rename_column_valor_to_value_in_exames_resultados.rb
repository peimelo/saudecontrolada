class RenameColumnValorToValueInExamesResultados < ActiveRecord::Migration[5.1]
  def change
    rename_column :exames_resultados, :valor, :value
  end
end
