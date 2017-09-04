class AlterResultadosValorPrecision < ActiveRecord::Migration[5.1]
  def change
    change_column :resultados, :valor, :decimal, precision: 10, scale: 2
  end
end
