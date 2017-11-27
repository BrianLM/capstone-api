class AddStepToExploration < ActiveRecord::Migration[5.0]
  def change
    add_column :explorations, :step, :integer
  end
end
