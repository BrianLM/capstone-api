class UserProfileSerializer < ActiveModel::Serializer
  attributes :experience, :level, :gold
  has_one :user
end
