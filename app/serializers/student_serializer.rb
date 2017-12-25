class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  has_many :courses
end
