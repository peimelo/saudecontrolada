class RemoveColumnDataFromExamesResultados < ActiveRecord::Migration
  def change
    remove_column :exames_resultados, :data
  end
end
