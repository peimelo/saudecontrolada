class RenameTableResultadosToResults < ActiveRecord::Migration[5.0]
  def change
    rename_table :resultados, :results
  end
end
