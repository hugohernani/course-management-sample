FactoryBot.define do
  factory :course do
    title Faker::Name.title
    description Faker::Lorem.paragraph

    trait(:with_students) do
      transient do
        n_students 2
      end

      after :build do |course, evaluator|
        course.students << build_list(:student, evaluator.n_students)
      end
    end

    trait(:with_teachers) do
      transient do
        n_teachers 2
      end

      after :build do |course, evaluator|
        course.teachers << build_list(:teacher, evaluator.n_teachers)
      end
    end
  end
end
