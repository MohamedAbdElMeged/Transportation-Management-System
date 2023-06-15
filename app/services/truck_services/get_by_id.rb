module TruckServices
  class GetById
    attr_accessor :truck_id
    def initialize(truck_id)
      @truck_id = truck_id
    end

    def call
      truck_by_id
    end

    private

    def truck_by_id
      Truck.find_by_id(@truck_id)
    end
  end
end
