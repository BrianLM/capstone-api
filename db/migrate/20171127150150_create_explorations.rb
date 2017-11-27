class CreateExplorations < ActiveRecord::Migration[5.0]
  def change
    create_table :explorations do |t|
      t.belongs_to :user, foreign_key: true
      t.string :current
      t.integer :top_f
      t.integer :top_m
      t.integer :top_p
      t.integer :top_d

      t.timestamps
    end
  end
end
