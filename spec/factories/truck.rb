FactoryBot.define do
  factory :truck do
    name { Faker::Vehicle.license_plate }
    truck_type { Faker::Vehicle.car_type }
  end
end
