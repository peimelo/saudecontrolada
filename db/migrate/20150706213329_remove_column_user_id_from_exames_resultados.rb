class RemoveColumnUserIdFromExamesResultados < ActiveRecord::Migration[5.1]
  def change
    remove_column :exames_resultados, :user_id
  end
end
