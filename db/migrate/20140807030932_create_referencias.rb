class CreateReferencias < ActiveRecord::Migration[5.1]
  def change
    create_table :referencias do |t|
      t.string :nome, null: false

      t.timestamps null: false
    end

    add_index :referencias, :nome, unique: true
  end
end
