# frozen_string_literal: true
class UserProfile < ApplicationRecord
  belongs_to :user

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.experience ||= 0
    self.gold ||= 0
    self.level ||= 1
    self.energy ||= Level.first.energy
    self.stat_points = 0
  end
end
