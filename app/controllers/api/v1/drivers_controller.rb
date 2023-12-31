module Api
  module V1
    class DriversController < ApplicationController
      skip_before_action :authorized

      def index
        @drivers = Driver.all
        render json: DriverSerializer.new(@drivers)
      end

      def create
        @driver = Driver.new(driver_params)
        if @driver.save
          render json: DriverSerializer.new(@driver), status: :created
        else
          render json: @driver.errors, status: :unprocessable_entity
        end
      end

      def login
        result = Drivers::Authenticate.call(login_params)
        if result.success?
          payload = Auth::JwtHelper.generate_payload(result.driver)
          token = Auth::JwtHelper.encode(payload)
          render json: { token: token }, status: :ok
        else
          render json: { message: result.message }, status: :unauthorized
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
