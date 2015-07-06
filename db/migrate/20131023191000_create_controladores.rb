class CreateControladores < ActiveRecord::Migration
  def up
    create_table :controladores do |t|
      t.string :nome, :null => false

      t.timestamps null: false
    end

    add_index :controladores, :nome, :unique => true
  end

  def down
    drop_table :controladores
  end
end