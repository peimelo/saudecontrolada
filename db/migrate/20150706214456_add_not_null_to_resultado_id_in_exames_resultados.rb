class AddNotNullToResultadoIdInExamesResultados < ActiveRecord::Migration
  def change
    change_column_null :exames_resultados, :resultado_id, false
  end
end
