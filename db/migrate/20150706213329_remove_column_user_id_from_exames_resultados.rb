class RemoveColumnUserIdFromExamesResultados < ActiveRecord::Migration
  def change
    remove_column :exames_resultados, :user_id
  end
end
