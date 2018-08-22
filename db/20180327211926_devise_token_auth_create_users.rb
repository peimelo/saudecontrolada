class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Recoverable
      t.boolean  :allow_password_change, :default => false

      ## User Info
      t.string :nickname
      t.string :image

      ## Tokens
      t.json :tokens
    end

    # Update :provider and :uid
    User.reset_column_information
    User.update_all(provider: :email)
    User.update_all('uid=email')

    add_index :users, [:uid, :provider],     unique: true
  end
end
