class RemoveColumnUserIdFromExamesResultados < ActiveRecord::Migration
  def change
    remove_foreign_key :exames_resultados, :users
    execute 'ALTER TABLE exames_resultados DROP INDEX resultados_user_id_fk;'
    remove_column :exames_resultados, :user_id
  end
end
