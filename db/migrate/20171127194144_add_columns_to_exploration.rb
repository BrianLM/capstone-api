class AddColumnsToExploration < ActiveRecord::Migration[5.0]
  def change
    add_column :explorations, :end, :integer
    add_column :explorations, :area, :string
  end
end
