FactoryBot.define do
  factory :student do
    name Faker::Name.name
    email Faker::Internet.free_email

    trait(:with_courses) do
      transient do
        n_courses 2
      end

      after :create do |student, evaluator|
        student.courses << create_list(:course, evaluator.n_courses)
      end
    end
  end
end
