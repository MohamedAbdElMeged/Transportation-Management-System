module Drivers
  class Authenticate
    include Interactor
    def call
      context.fail!(message: 'email and password should be sent') unless context&.[]('email') && context&.[]('password')
      context.email = context&.[]('email')
      context.password = context&.[]('password')
      authenticate
    end

    private

    def authenticate
      driver = Driver.find_by(email: context.email)
      context.fail!(message: 'invalid email/password') unless driver && driver&.authenticate(context.password)
      context.driver = driver
    end
  end
end
