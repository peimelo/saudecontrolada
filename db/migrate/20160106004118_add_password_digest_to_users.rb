class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string, null: false, default: ''
    execute 'UPDATE users SET password_digest = encrypted_password'
  end
end
