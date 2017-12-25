FactoryBot.define do
  factory :teacher do
    name Faker::Name.name

    trait(:with_courses) do
      transient do
        n_courses 2
      end

      after :create do |teacher, evaluator|
        teacher.courses << create_list(:course, evaluator.n_courses)
      end
    end
  end
end
