FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    grade_id { Faker::Number.between(from: 1, to: 7) }
    subject_id { Faker::Number.between(from: 1, to: 15) }
    course_id { Faker::Number.between(from: 1, to: 30) }
    introduction { Faker::Lorem.sentence }
  end
end