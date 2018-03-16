class RenameTableResultadosToResults < ActiveRecord::Migration[5.1]
  def change
    rename_table :resultados, :results
  end
end
