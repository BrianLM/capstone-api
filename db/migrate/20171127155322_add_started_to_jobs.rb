class AddStartedToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :started, :datetime
  end
end
