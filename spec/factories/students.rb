FactoryBot.define do
  factory :student do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { :active }
    after(:build) do |student|
      student.avatar.attach(io: Rails.root.join('spec/factories/images/default_profile.png').open,
                            filename: 'default_profile.png', content_type: 'image/png')
    end
  end
end
