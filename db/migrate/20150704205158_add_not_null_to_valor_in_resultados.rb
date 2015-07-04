class AddNotNullToValorInResultados < ActiveRecord::Migration
  def change
    change_column_null :resultados, :valor, false
  end
end
