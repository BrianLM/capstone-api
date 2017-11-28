class ChangeTypeInItems < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :type, :name
  end
end
