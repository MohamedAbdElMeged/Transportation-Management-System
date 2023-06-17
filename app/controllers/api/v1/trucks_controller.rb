module Api
  module V1
    class TrucksController < ApplicationController
      before_action :authorized
      before_action :set_truck, only: [:assign_truck]
      def index
        @trucks = Truck.all
        render json: TruckBlueprint.render_as_hash(@trucks), status: :ok
      end

      def assign_truck
        # @drivers_truck = TruckServices::AssignTruck.new(@driver, @truck).call
        result = Trucks::AssignTruck.call(truck: @truck, driver: @driver)
        if result.success?
          render json: DriversTruckBlueprint.render_as_hash(result.drivers_truck, view: :assign_truck), status: :created
        else
          render json: { message: "can\'t assign" }, status: :unprocessable_entity
        end
      end

      def assigned_trucks
        @drivers_trucks = @driver.drivers_trucks
        render json: DriversTruckBlueprint.render_as_hash(@drivers_trucks, view: :assigned_trucks), status: :ok
      end

      private

      def set_truck
        @truck = Truck.find_by(id: params[:truck_id])
        render json: { error: 'Truck Not Found' }, status: 404 unless @truck
      end
    end
  end
end
