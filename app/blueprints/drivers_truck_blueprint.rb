class DriversTruckBlueprint < Blueprinter::Base
  identifier :id
  fields :assigned_at
  view :assigned_trucks do
    association :truck, blueprint: TruckBlueprint
  end
  view :assign_truck do
    include_view :assigned_trucks
    association :driver, blueprint: DriverBlueprint
  end
end
