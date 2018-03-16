class ChangePesosData < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      change_table :pesos do |t|
        dir.up   { t.change :data, :date }
        dir.down { t.change :data, :datetime }
      end
    end
  end
end
