FactoryBot.define do
  factory :task do
    # user { nil }
    title { Faker::Artist.name }
    content { Faker::Lorem.paragraph(4) }
    # status { nil }
    # priority { nil }
    end_at { 5.days.from_now }
  end
end
