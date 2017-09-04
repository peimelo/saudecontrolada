class DropControladores < ActiveRecord::Migration[5.1]
  def change
    drop_table :controladores
  end
end
