FactoryBot.define do
  factory :task do
    user { nil }
    title { "MyString" }
    content { "MyText" }
    status { "MyString" }
    priority { "MyString" }
    start_at { "2019-07-08" }
    end_at { "2019-07-08" }
  end
end
