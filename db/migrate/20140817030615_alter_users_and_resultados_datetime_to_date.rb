class AlterUsersAndResultadosDatetimeToDate < ActiveRecord::Migration
  def change
    change_column :users, :date_of_birth, :date, null: true
    change_column :resultados, :data, :date, null: false
  end
end
