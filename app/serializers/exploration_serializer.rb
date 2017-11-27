class ExplorationSerializer < ActiveModel::Serializer
  attributes :id, :current, :top_f, :top_m, :top_p, :top_d
  has_one :user
end
