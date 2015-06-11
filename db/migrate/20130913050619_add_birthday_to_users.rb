class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :datetime, null: false
  end
end
