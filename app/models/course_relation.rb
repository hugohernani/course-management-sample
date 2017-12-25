class CourseRelation < ApplicationRecord
  belongs_to :course
  belongs_to :entity, polymorphic: true
end
