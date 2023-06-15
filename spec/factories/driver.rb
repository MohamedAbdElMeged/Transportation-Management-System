FactoryBot.define do
  factory :driver do
    email { Faker::Internet.email }
    password { '123456789' }
  end
end
