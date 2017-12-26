module Api
  module V1
    module Courses
      class AssignEntityController < ApplicationController
        def create
          job = AssignAndNotifyEntityJob.perform_later(course, teacher, student)
          render json: JobStatusSerializer.serialize(job), status: :accepted
        end

        def destroy
          job = RemoveAndNotifyEntityJob.perform_later(course, teacher, student)
          render json: JobStatusSerializer.serialize(job), status: :accepted
        end

        private
        def assign_params
          params.require(:data).permit(:type, {
            attributes: [:course_id, :teacher_id, :student_id]
          })
        end

        def assign_attributes
          assign_params[:attributes] || {}
        end

        def course
          @course ||= Course.find(assign_attributes[:course_id])
        end

        def teacher
          @course ||= Teacher.find(assign_attributes[:teacher_id])
        end

        def student
          @student ||= Student.find(assign_attributes[:student_id])
        end
      end
    end
  end
end
