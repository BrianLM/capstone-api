class JobSerializer < ActiveModel::Serializer
  attributes :id, :payout, :skill, :duration
  has_one :user
end
