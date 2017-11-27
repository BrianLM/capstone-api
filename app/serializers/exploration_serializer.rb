# frozen_string_literal: true

class ExplorationSerializer < ActiveModel::Serializer
  attributes :area, :step, :end, :encounter, :top_f, :top_m, :top_p, :top_d
end
