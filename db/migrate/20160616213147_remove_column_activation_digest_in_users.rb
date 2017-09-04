class RemoveColumnActivationDigestInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :activation_digest
  end
end
