module Api
  module V1
    class TrucksController < ApplicationController
      before_action :authorized
      before_action :set_truck, only: [:assign_truck]
      def index
        @trucks = Truck.all
        render json: TruckSerializer.new(@trucks)
      end

      def assign_truck
        result = Trucks::AssignTruck.call(truck: @truck, driver: @driver)
        if result.success?
          render json: DriversTruckSerializer.new(result.drivers_truck), status: :created
        else
          render json: { message: "can\'t assign" }, status: :unprocessable_entity
        end
      end

      def assigned_trucks
        @drivers_trucks = @driver.drivers_trucks
        render json: DriversTruckSerializer.new(@drivers_trucks, assigned_api: true), status: :ok
      end

      private

      def set_truck
        @truck = Truck.find_by(id: params[:truck_id])
        render json: { error: 'Truck Not Found' }, status: 404 unless @truck
      end
    end
  end
end
