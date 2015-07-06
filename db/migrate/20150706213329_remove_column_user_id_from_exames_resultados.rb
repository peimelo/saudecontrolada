class RemoveColumnUserIdFromExamesResultados < ActiveRecord::Migration
  def change
    # execute 'ALTER TABLE exames_resultados DROP INDEX resultados_user_id_fk;'
    remove_column :exames_resultados, :user_id
  end
end
