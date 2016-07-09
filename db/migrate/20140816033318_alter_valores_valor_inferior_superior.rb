class AlterValoresValorInferiorSuperior < ActiveRecord::Migration
  def change
    change_column :valores, :valor_inferior, :decimal, precision: 10, scale: 2
    change_column :valores, :valor_superior, :decimal, precision: 10, scale: 2
  end
end
