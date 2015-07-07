class AddNotNullToDateOfBirthInUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :date_of_birth, false
  end
end
