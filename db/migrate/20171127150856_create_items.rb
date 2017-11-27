class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.belongs_to :user, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
