class RenameUsersBirthdayToDateOfBirth < ActiveRecord::Migration
  def change
    rename_column :users, :birthday, :date_of_birth
  end
end
