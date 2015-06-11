class UsersDateOfBirthdayNull < ActiveRecord::Migration
  def change
    change_column :users, :date_of_birth, :datetime, null: true
  end
end
