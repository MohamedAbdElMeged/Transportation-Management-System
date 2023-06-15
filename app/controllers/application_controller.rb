class ApplicationController < ActionController::API
    before_action :authorized

    def auth_header
        request.headers['Authorization']
    end
    def get_token
        if auth_header 
          return auth_header.split(' ')[1]
        end
    end
    def logged_in_driver
        token = get_token
        return unless token
        decoded_hash = Auth::JwtHelper.decode(token)
        decoded_hash = decoded_hash.with_indifferent_access
        @driver = DriverServices::GetByEmail.new(email=decoded_hash["email"]).call
        @driver
    end
    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in_driver
    end
end
