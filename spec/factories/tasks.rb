FactoryBot.define do
  factory :task do
    user { 1 }
    title { Faker::Artist.name }
    content { Faker::Lorem.paragraph(4) }
    # priority { 0 }
    end_at { 5.days.from_now }
  end

  trait :task_earlier do
    end_at { 2.days.from_now }
  end

  trait :task_later do
    end_at { 10.days.from_now }
  end

  trait :task_medium do
    priority { 1 }
  end

  trait :task_high do
    priority { 2 }
  end
end
