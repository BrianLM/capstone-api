class AddQuantityToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :quantity, :integer
  end
end
