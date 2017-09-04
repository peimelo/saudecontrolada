class AddGenderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :string
    change_column_null :users, :gender, false
  end
end
