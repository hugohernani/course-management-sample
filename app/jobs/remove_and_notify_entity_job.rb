class RemoveAndNotifyEntityJob < ApplicationJob
  queue_as :default

  def perform(course, teacher, student)
    # Do heavy work within service objects. Just a simulation
    course.teachers.remove teacher
    course.students.remove student
  end
end
