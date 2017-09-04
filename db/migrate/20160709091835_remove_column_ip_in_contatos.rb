class RemoveColumnIpInContatos < ActiveRecord::Migration[5.1]
  def change
    remove_column :contatos, :ip
  end
end
