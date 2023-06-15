class DriversTruckBlueprint < Blueprinter::Base
  identifier :id
  fields :assigned_at
  association :truck, blueprint: TruckBlueprint
  association :driver, blueprint: DriverBlueprint
end
