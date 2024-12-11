FactoryBot.define do
  factory :instructor do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { :active }
    role { :instructor }
    after(:build) do |instructor|
      instructor.avatar.attach(io: Rails.root.join('spec/factories/images/default_profile.png').open,
                               filename: 'default_profile.png', content_type: 'image/png')
    end
  end
end
