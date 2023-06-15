module Api
    module V1
        class DriversController < ApplicationController
            before_action :authorized, except: [:create,:login]
            
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
                @driver = DriverServices::GetByEmail.new(login_params["email"]).call
                if @driver && @driver.authenicate(login_params["password"])
                    payload = Auth::JwtHelper.generate_payload(@driver)
                    token = Auth::Jwt.encode(payload)
                    render json: token, status: :ok
                end
                render json: "invalid email/password", status: :bad_request 
            end
            private
            def login_params
                params.require(:driver).permit(:email,:password)
            end
            def driver_params
                params.require(:driver).permit(:email,:password,:password_confirmation)
            end
        end        
    end
end