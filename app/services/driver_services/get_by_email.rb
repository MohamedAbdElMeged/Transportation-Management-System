module DriverServices
  class GetByEmail
    def initialize(email)
      @email = email
    end

    def call
      driver_by_email
    end

    private

    def driver_by_email
      Driver.find_by_email(@email)
    end
  end
end
