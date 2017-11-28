# frozen_string_literal: true
class User < ApplicationRecord
  include Authentication
  has_one :user_profile
  has_one :creature
  has_one :exploration
  has_one :encounter
  has_many :items
  has_many :jobs
  has_many :parts
  has_many :examples
end
