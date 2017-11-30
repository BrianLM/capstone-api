class UserProfileSerializer < ActiveModel::Serializer
  attributes :experience, :level, :gold, :energy, :els, :stat_points,
             :exploration, :encounter, :items, :creature
  # has_one :user
end
