class UsersDateOfBirthdayNull < ActiveRecord::Migration
  def change
    change_column :users, :date_of_birth, :string, null: true
  end
end
