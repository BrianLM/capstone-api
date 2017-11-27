class RemoveCurrentFromExploration < ActiveRecord::Migration[5.0]
  def change
    remove_column :explorations, :current, :string
  end
end
