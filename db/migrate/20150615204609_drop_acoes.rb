class DropAcoes < ActiveRecord::Migration[5.1]
  def change
    drop_table :acoes
  end
end
