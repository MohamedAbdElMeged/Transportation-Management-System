module Api
  module V1
    class TrucksController < ApplicationController
      before_action :authorized
      before_action :set_truck
      def index
        @trucks = Truck.all
        render json: TruckBlueprint.render_as_hash(@trucks), status: :ok
      end

      def assign_truck
        @drivers_truck = @driver.drivers_trucks.build
        @drivers_truck.truck = @truck
        if @drivers_truck.save
          render json: DriversTruckBlueprint.render_as_hash(@drivers_truck), status: :created
        else
          render json: @drivers_truck.errors, status: :unprocessable_entity
        end
      end

      private

      def set_truck
        @truck = Truck.find_by_id(params[:truck_id])
        render json: { error: 'Truck Not Found' }, status: 404 unless @truck
      end
    end
  end
end
