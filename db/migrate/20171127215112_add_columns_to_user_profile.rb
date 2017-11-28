class AddColumnsToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :energy, :integer
    add_column :user_profiles, :els, :datetime
  end
end
