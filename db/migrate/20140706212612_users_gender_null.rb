class UsersGenderNull < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :gender, :string, null: true
  end
end
