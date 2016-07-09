class UsersGenderNull < ActiveRecord::Migration
  def change
    change_column :users, :gender, :string, null: true
  end
end
