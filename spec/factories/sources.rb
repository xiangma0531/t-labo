FactoryBot.define do
  factory :source do
    title { Faker::Book.title }
    grade_id { Faker::Number.between(from: 1, to: 7) }
    subject_id { Faker::Number.between(from: 1, to: 15) }
    course_id { Faker::Number.between(from: 1, to: 30) }
    content { Faker::Lorem.sentence }
    association :user

    after(:build) do |source|
      source.image.attach(io: File.open('public/images/dammy.png'), filename: 'dammy.png')
    end
  end
end
