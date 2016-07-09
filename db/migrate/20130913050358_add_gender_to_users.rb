class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    change_column_null :users, :gender, false
  end
end
