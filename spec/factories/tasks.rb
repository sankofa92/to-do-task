FactoryBot.define do
  factory :task do
    # user { nil }
    title { Faker::Artist.name }
    content { Faker::Lorem.paragraph(4) }
    status { nil }
    priority { nil }
    start_at { nil }
    end_at { nil }
  end
end
