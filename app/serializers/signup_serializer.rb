class SignupSerializer < ActiveModel::Serializer
  attributes :id, :time, :camper_id, :activity_id
  has_one :camper
  has_one :activity
end
