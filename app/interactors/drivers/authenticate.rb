module Drivers
    class Authenticate
        include Interactor
        def call
            unless context&.[]('email') && context&.[]('password')
                context.fail!(message: "email and password should be sent")
            end
            context.email = context&.[]('email')
            context.password = context&.[]('password')
            authenticate
        end
        private
        def authenticate
            driver = Driver.find_by(email: context.email)
            unless driver && driver&.authenticate(context.password)
                context.fail!(message: "invalid email/password")
            end    
            context.driver = driver 
        end
    end
end
