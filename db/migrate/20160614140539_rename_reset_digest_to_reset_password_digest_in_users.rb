class RenameResetDigestToResetPasswordDigestInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :reset_digest, :reset_password_digest
  end
end
