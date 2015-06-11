class CreateAcoes < ActiveRecord::Migration
  def up
    create_table :acoes do |t|
      t.string :nome, :null => false

      t.timestamps
    end

    add_index :acoes, :nome, :unique => true
  end

  def down
    drop_table :acoes
  end
end