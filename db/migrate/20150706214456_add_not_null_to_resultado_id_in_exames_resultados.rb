class AddNotNullToResultadoIdInExamesResultados < ActiveRecord::Migration[5.1]
  def change
    change_column_null :exames_resultados, :resultado_id, false
  end
end
