class CreateAcoes < ActiveRecord::Migration[5.1]
  def up
    create_table :acoes do |t|
      t.string :nome, :null => false

      t.timestamps null: false
    end

    add_index :acoes, :nome, :unique => true
  end

  def down
    drop_table :acoes
  end
end