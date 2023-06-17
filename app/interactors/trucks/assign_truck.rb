module Trucks
  class AssignTruck
    include Interactor
    def call
      context.fail!(message: 'driver and truck should be sent') unless context&.[]('driver') && context&.[]('truck')
      assign_truck
    end

    private

    def assign_truck
      context.drivers_truck = DriversTruck.create_or_find_by(driver_id: context.driver.id, truck_id: context.truck.id)
    end
  end
end
