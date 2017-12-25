FactoryBot.define do
  factory :student do
    name Faker::Name.name
    email Faker::Internet.free_email
  end
end
