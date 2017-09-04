class AddNotNullToValorInResultados < ActiveRecord::Migration[5.1]
  def change
    change_column_null :resultados, :valor, false
  end
end
