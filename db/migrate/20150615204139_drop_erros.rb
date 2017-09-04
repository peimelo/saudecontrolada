class DropErros < ActiveRecord::Migration[5.1]
  def change
    drop_table :erros
  end
end
