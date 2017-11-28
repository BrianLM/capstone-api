class Encounter < ApplicationRecord
  belongs_to :user
  belongs_to :exploration

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.c_hp ||= rand(5..10)
    self.c_def ||= rand(1..3)
    self.c_dex ||= rand(1..3)
    self.c_spd ||= rand(1..3)
    self.c_int ||= rand(1..3)
    self.c_sig ||= rand(1..3)
    self.c_str ||= rand(1..3)
  end
end
