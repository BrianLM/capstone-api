class UserProfileSerializer < ActiveModel::Serializer
  attributes :id, :experience, :level, :gold
  has_one :user
end
