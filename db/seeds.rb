teacher1 = Teacher.create(name: 'Jack')
teacher2 = Teacher.create(name: 'Louis')
student1 = Student.create(name: 'Peter', email: 'peter@fractal-technology.com')
student2 = Student.create(name: 'John', email: 'john@fractal-technology.com')

rails_course = Course.create(title: 'Rails API',
  description: 'Rails API development')

rails_course.teachers << [teacher1, teacher2]
rails_course.students << [student1, student2]

5.times do |i|
  FactoryBot.create(:course, :with_teachers, :with_students)
end
