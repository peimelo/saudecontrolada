class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.references :user, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps null: false
    end
    add_foreign_key :authentications, :users
  end

  def self.down
    drop_table :authentications
  end
end
