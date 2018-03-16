class UsersDateOfBirthdayNull < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :date_of_birth, :datetime, null: true
  end
end
