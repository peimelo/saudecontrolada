class AlterResultadosValorPrecision < ActiveRecord::Migration
  def change
    change_column :resultados, :valor, :decimal, precision: 10, scale: 2
  end
end
