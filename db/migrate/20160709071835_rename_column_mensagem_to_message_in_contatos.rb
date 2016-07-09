class RenameColumnMensagemToMessageInContatos < ActiveRecord::Migration[5.0]
  def change
    rename_column :contatos, :mensagem, :message
  end
end
