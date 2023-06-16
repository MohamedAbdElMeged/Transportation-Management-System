FactoryBot.define do
  factory :driver do
    email { Faker::Internet.email }
    password { '123456789' }
    password_confirmation { '123456789' }
  end
end
