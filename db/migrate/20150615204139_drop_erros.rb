class DropErros < ActiveRecord::Migration
  def change
    drop_table :erros
  end
end
