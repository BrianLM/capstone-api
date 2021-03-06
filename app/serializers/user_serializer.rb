# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :user_profile, :exploration, :creature, :encounter
end
