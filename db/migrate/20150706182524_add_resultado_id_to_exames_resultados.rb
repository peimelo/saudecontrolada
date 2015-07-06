class AddResultadoIdToExamesResultados < ActiveRecord::Migration
  def change
    add_column :exames_resultados, :resultado_id, :integer, null: true
    add_foreign_key :exames_resultados, :resultados
  end
end
