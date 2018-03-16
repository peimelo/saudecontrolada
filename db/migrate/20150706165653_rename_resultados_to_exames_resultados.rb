class RenameResultadosToExamesResultados < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :resultados, :exames
    remove_foreign_key :resultados, :users
    rename_table :resultados, :exames_resultados
  end
end
