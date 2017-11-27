class Exploration < ApplicationRecord
  belongs_to :user
  has_one :encounter
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.top_f ||= 0
    self.top_m ||= 0
    self.top_d ||= 0
    self.top_p ||= 0
  end
end
