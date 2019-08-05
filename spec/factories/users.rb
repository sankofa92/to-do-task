FactoryBot.define do
  factory :user do
    name { 'admin' }
    email { 'admin@example.com' }
    password { '123456' }
  end

  trait :other_user do
    name { 'other' }
    email { 'other@example.com' }
  end

end
