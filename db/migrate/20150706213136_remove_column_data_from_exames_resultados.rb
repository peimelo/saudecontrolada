class RemoveColumnDataFromExamesResultados < ActiveRecord::Migration[5.1]
  def change
    remove_column :exames_resultados, :data
  end
end
