FactoryBot.define do
  factory :truck do
    name { Faker::Vehicle.make_and_model }
    truck_type { Faker::Vehicle.car_type }
  end
end
