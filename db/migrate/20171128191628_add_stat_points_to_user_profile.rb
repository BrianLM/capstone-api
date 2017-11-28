class AddStatPointsToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :stat_points, :integer
  end
end
