FactoryBot.define do
  factory :user do
    name { 'admin' }
    email { 'admin@example.com' }
    password { '123456' }
  end
end
