class Teacher < ApplicationRecord
  validates :name, presence: true

  has_many :course_relation, as: :entity, dependent: :destroy
  has_many :courses, through: :course_relation
end
