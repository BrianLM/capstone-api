class CreateLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :required
      t.integer :energy

      t.timestamps
    end
  end
end
