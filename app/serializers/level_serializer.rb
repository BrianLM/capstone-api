class LevelSerializer < ActiveModel::Serializer
  attributes :id, :level, :required, :energy
end
