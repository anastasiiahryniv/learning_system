FactoryBot.define do
  factory :course do
    association :instructor

    name { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
    status { :inactive }
  end
end
