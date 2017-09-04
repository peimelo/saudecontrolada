class AddUniqueIndexInExamesResultados < ActiveRecord::Migration[5.1]
  def change
    add_index :exames_resultados, [:exame_id, :resultado_id], unique: true
  end
end
