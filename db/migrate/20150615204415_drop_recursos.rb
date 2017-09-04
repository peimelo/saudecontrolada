class DropRecursos < ActiveRecord::Migration[5.1]
  def change
    drop_table :recursos
  end
end
