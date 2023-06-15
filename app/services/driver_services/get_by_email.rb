module DriverServices
    class GetByEmail
        def initialize(email)
            @email = email
        end
        def call
            @driver = get_driver_by_email
            @driver
        end
        private
        def get_driver_by_email
            Driver.find_by_email(@email)
        end
    end
end