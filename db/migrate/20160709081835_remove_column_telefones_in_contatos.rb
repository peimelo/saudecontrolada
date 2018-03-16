class RemoveColumnTelefonesInContatos < ActiveRecord::Migration[5.1]
  def change
    remove_column :contatos, :telefones
  end
end
