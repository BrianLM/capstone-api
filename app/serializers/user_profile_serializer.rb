class UserProfileSerializer < ActiveModel::Serializer
  attributes :experience, :level, :gold, :energy, :els, :stat_points
  # has_one :user
end
