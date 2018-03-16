class RemoveUniqueIndexOnExames < ActiveRecord::Migration[5.1]
  def change
    remove_index :exames, [:nome, :ancestry]
  end
end
