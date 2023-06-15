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
        @drivers_truck = TruckServices::AssignTruck.new(@driver, @truck).call
        render json: DriversTruckBlueprint.render_as_hash(@drivers_truck, view: :assign_truck), status: :created
      end

      def assigned_trucks
        @drivers_trucks = @driver.drivers_trucks
        render json: DriversTruckBlueprint.render_as_hash(@drivers_trucks, view: :assigned_trucks), status: :ok
      end

      private

      def set_truck
        @truck = TruckServices::GetById.new(params[:id]).call
        render json: { error: 'Truck Not Found' }, status: 404 unless @truck
      end
    end
  end
end
