module Api
  module V1
    class DriversController < ApplicationController
      skip_before_action :authorized

      def index
        @drivers = Driver.all
        render json: DriverBlueprint.render_as_hash(@drivers), status: :ok
      end

      def create
        @driver = Driver.new(driver_params)
        if @driver.save
          render json: DriverBlueprint.render_as_hash(@driver), status: :created
        else
          render json: @driver.errors, status: :unprocessable_entity
        end
      end

      def login
        driver = Drivers::Authenticate.call(login_params)
        if driver.driver
          payload = Auth::JwtHelper.generate_payload(driver.driver)
          token = Auth::JwtHelper.encode(payload)
          render json: { token: token }, status: :ok
        else
          render json: { message: driver.message }, status: :unauthorized
        end
      end

      private

      def login_params
        params.require(:driver).permit(:email, :password)
      end

      def driver_params
        params.require(:driver).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
