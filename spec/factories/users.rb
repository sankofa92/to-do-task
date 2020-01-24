FactoryBot.define do
  factory :user do
    name { 'admin' }
    email { 'admin@example.com' }
    password { '123456' }
    role { 'admin' }
  end

  trait :other_user do
    name { 'other' }
    email { 'other@example.com' }
    role { 'normal' }
  end

end
