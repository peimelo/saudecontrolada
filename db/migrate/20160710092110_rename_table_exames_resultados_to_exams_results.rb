class RenameTableExamesResultadosToExamsResults < ActiveRecord::Migration[5.0]
  def change
    rename_table :exames_resultados, :exams_results
  end
end
