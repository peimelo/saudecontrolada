class DropAcoes < ActiveRecord::Migration
  def change
    drop_table :acoes
  end
end
