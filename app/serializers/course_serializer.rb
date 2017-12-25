class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :students
  has_many :teachers
end
