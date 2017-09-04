class RenameUsersBirthdayToDateOfBirth < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :birthday, :date_of_birth
  end
end
