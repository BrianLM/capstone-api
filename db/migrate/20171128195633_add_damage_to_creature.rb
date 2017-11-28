class AddDamageToCreature < ActiveRecord::Migration[5.0]
  def change
    add_column :creatures, :damage, :integer
  end
end
