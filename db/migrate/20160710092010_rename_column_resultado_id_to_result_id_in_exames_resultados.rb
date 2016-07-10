class RenameColumnResultadoIdToResultIdInExamesResultados < ActiveRecord::Migration[5.0]
  def change
    rename_column :exames_resultados, :resultado_id, :result_id
  end
end
