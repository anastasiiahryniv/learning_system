FactoryBot.define do
  factory :instructor do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    status { 10 }
  end
end
