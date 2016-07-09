class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :datetime
    change_column_null :users, :birthday, false
  end
end
