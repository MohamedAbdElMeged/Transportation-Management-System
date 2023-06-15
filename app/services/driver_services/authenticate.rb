module DriverServices
  class Authenticate
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      authenticate
    end

    private

    def authenticate
      driver = DriverServices::GetByEmail.new(@email).call
      return driver if driver&.authenticate(@password)

      nil
    end
  end
end
