module SwaggerDocs
  module V1
    module Courses
      module AssignEntity
        extend ActiveSupport::Concern

        included do
          swagger_controller :assign_entity, 'Assign or Unassign Entity Into Course'

          swagger_api :create do
            summary 'Assigns student and teacher into a course'
            notes 'It receives ids for student, teacher and course'
            param :form, 'data[type]', :string, :optional, 'Object type (queue-jobs)'
            param :form, 'data[attributes[course_id]]', :integer, :required, "Course's id"
            param :form, 'data[attributes[teacher_id]]', :integer, :required, "Teacher's id"
            param :form, 'data[attributes[student_id]]', :integer, :required, "Student's id"
            response :accepted
          end

          swagger_api :destroy do
            summary 'Unassigns student and teacher from a course'
            notes 'It receives ids for student, teacher and course'
            param :form, 'data[type]', :string, :optional, 'Object type (queue-jobs)'
            param :form, 'data[attributes[course_id]]', :integer, :required, "Course's id"
            param :form, 'data[attributes[teacher_id]]', :integer, :required, "Teacher's id"
            param :form, 'data[attributes[student_id]]', :integer, :required, "Student's id"
            response :accepted
          end
        end
      end
    end
  end
end
