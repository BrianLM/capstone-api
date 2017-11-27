# frozen_string_literal: true

class PartSerializer < ActiveModel::Serializer
  attributes :id, :c_hp, :c_def, :c_dex, :c_spd, :c_int, :c_sig, :c_str, :m_hp,
             :m_def, :m_dex, :m_spd, :m_int, :m_sig, :m_str
  has_one :creature
  has_one :user
end
