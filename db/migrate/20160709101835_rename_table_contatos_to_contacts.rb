class RenameTableContatosToContacts < ActiveRecord::Migration[5.1]
  def change
    rename_table :contatos, :contacts
  end
end
