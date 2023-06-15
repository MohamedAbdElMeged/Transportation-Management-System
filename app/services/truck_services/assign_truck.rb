module TruckServices
  class AssignTruck
    attr_accessor :driver, :truck
    def initialize(driver, truck)
      @driver = driver
      @truck = truck
    end

    def call
      assign_truck
    end

    private

    def assign_truck
      DriversTruck.create_or_find_by(driver_id: @driver.id, truck_id: @truck.id)
    end
  end
end
