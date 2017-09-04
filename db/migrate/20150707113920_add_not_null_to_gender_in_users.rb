class AddNotNullToGenderInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :gender, false
  end
end
