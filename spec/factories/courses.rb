FactoryBot.define do
  factory :course do
    title Faker::Name.title
    description Faker::Lorem.paragraph
  end
end
