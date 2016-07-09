class DropErrosStatus < ActiveRecord::Migration
  def change
    drop_table :erros_status
  end
end
