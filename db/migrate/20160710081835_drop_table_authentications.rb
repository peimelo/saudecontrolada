class DropTableAuthentications < ActiveRecord::Migration[5.1]
  def change
    drop_table :authentications
  end
end
