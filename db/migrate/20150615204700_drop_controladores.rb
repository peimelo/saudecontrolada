class DropControladores < ActiveRecord::Migration
  def change
    drop_table :controladores
  end
end
