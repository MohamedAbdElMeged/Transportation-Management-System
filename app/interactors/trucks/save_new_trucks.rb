module Trucks
  class SaveNewTrucks
    include Interactor
    def call
      context.fail!(message: 'No new trucks found') unless context.response_body
      trucks = map_to_trucks_instances
      save_trucks(trucks)
    end

    private

    def map_to_trucks_instances
      context.response_body.map { |truck| Truck.new(truck) }
    end

    def save_trucks(trucks)
      Truck.import!(trucks)
    end
  end
end
