class RemoveUniqueIndexOnExames < ActiveRecord::Migration
  def change
    remove_index :exames, [:nome, :ancestry]
  end
end
