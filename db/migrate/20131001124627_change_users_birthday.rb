class ChangeUsersBirthday < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :users do |t|
        dir.up   { t.change :birthday, :date }
        dir.down { t.change :birthday, :datetime }
      end
    end
  end
end
