class CreateCreatures < ActiveRecord::Migration[5.0]
  def change
    create_table :creatures do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :c_hp
      t.integer :c_def
      t.integer :c_dex
      t.integer :c_spd
      t.integer :c_int
      t.integer :c_sig
      t.integer :c_str
      t.integer :m_hp
      t.integer :m_def
      t.integer :m_dex
      t.integer :m_spd
      t.integer :m_int
      t.integer :m_sig
      t.integer :m_str

      t.timestamps
    end
  end
end
