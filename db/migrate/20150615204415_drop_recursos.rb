class DropRecursos < ActiveRecord::Migration
  def change
    drop_table :recursos
  end
end
