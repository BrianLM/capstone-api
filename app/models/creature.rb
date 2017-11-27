class Creature < ApplicationRecord
  belongs_to :user

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.c_hp ||= rand(25..30)
    self.c_def ||= rand(4..10)
    self.c_dex ||= rand(4..10)
    self.c_spd ||= rand(4..10)
    self.c_int ||= rand(4..10)
    self.c_sig ||= rand(4..10)
    self.c_str ||= rand(4..10)
    self.m_hp ||= c_hp * 1.2
    self.m_def ||= c_def * 1.2
    self.m_dex ||= c_dex * 1.2
    self.m_spd ||= c_spd * 1.2
    self.m_int ||= c_int * 1.2
    self.m_sig ||= c_sig * 1.2
    self.m_str ||= c_str * 1.2
  end
end
