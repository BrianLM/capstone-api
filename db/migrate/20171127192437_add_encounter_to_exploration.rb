class AddEncounterToExploration < ActiveRecord::Migration[5.0]
  def change
    add_reference :explorations, :encounter, foreign_key: true
  end
end
