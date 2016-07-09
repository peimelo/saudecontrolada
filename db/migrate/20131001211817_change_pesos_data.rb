class ChangePesosData < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :pesos do |t|
        dir.up   { t.change :data, :date }
        dir.down { t.change :data, :datetime }
      end
    end
  end
end
