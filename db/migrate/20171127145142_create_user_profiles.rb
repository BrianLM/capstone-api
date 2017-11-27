# frozen_string_literal: true

class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.number :experience
      t.number :level
      t.number :gold

      t.timestamps
    end
  end
end
