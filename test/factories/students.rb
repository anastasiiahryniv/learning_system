FactoryBot.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { 10 }
  end
end
