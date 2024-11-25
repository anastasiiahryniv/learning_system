FactoryBot.define do
  factory :instructor do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { :active }
    role { :instructor }
  end
end
