class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :payout
      t.string :skill
      t.integer :duration

      t.timestamps
    end
  end
end
