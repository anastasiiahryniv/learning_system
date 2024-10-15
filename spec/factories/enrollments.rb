FactoryBot.define do
  factory :enrollment do
    association :student
    association :course
    grade { rand(1..10) }
    status { 10 }
  end
end
