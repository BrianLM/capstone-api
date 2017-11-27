class Encounter < ApplicationRecord
  belongs_to :user
  belongs_to :exploration
end
