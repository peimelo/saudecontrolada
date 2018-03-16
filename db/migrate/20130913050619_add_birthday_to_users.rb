class AddBirthdayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birthday, :datetime
    change_column_null :users, :birthday, false
  end
end
