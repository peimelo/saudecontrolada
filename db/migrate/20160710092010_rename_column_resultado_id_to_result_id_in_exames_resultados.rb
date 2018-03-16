class RenameColumnResultadoIdToResultIdInExamesResultados < ActiveRecord::Migration[5.1]
  def change
    rename_column :exames_resultados, :resultado_id, :result_id
  end
end
