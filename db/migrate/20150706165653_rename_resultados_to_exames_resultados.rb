class RenameResultadosToExamesResultados < ActiveRecord::Migration
  def change
    rename_table :resultados, :exames_resultados
  end
end
