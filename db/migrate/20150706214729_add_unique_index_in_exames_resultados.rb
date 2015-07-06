class AddUniqueIndexInExamesResultados < ActiveRecord::Migration
  def change
    add_index :exames_resultados, [:exame_id, :resultado_id], unique: true
  end
end
