class AddColumnToExploration < ActiveRecord::Migration[5.0]
  def change
    add_column :explorations, :dif, :integer
  end
end
