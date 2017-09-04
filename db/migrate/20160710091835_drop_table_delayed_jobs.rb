class DropTableDelayedJobs < ActiveRecord::Migration[5.1]
  def change
    drop_table :delayed_jobs
  end
end
