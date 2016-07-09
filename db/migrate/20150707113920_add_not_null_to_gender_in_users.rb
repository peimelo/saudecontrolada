class AddNotNullToGenderInUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :gender, false
  end
end
