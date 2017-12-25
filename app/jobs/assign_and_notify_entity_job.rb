class AssignAndNotifyEntityJob < ApplicationJob
  queue_as :default

  def perform(course, teacher, student)
    # Do heavy work within service objects. Just a simulation
    course.teachers << teacher
    course.students << student
  end
end
