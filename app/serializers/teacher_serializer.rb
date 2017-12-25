class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :courses
end
