class DropErrosStatus < ActiveRecord::Migration[5.1]
  def change
    drop_table :erros_status
  end
end
