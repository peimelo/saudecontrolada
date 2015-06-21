class RecreateUniqueIndexExame < ActiveRecord::Migration
  def change
    remove_index :exames, :nome
    add_index :exames, [:nome, :ancestry], unique: true
  end
end
