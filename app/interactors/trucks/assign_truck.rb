module Trucks
  class AssignTruck
    include Interactor
    def call
      assign_truck
    end

    private

    def assign_truck
      context.drivers_truck = DriversTruck.create_or_find_by(driver_id: context.driver.id, truck_id: context.truck.id)
    end
  end
end
