class Course < ApplicationRecord
  validates :title, :description, presence: true

  has_many :course_relation, dependent: :destroy
  has_many :students, through: :course_relation, source: :entity, source_type: 'Student'
  has_many :teachers, through: :course_relation, source: :entity, source_type: 'Teacher'
end
