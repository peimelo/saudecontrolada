class CreateExames < ActiveRecord::Migration
  def change
    create_table :exames do |t|
      t.string :nome, null: false

      t.timestamps
    end

    add_index :exames, :nome, unique: true
  end
end