class CreateEncounters < ActiveRecord::Migration[5.0]
  def change
    create_table :encounters do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :exploration, foreign_key: true
      t.integer :c_hp
      t.integer :c_def
      t.integer :c_dex
      t.integer :c_spd
      t.integer :c_int
      t.integer :c_sig
      t.integer :c_str

      t.timestamps
    end
  end
end
