FactoryBot.define do
  factory :task do
    # user { nil }
    title { Faker::Artist.name }
    content { Faker::Lorem.paragraph(4) }
    # status { nil }
    # priority { nil }
    end_at { 5.days.from_now }
  end

  trait :task_earlier do
    end_at { 2.days.from_now }
  end

  trait :task_later do
    end_at { 10.days.from_now }
  end
end
