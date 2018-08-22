# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Trackable
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
    end

    # Update :encrypted_password
    User.reset_column_information
    User.update_all('encrypted_password=password_digest')
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
