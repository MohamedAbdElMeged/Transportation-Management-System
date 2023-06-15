module Auth
  module JwtHelper
    SECRET_KEY = ENV['JWT_SECRET']
    def self.encode(payload, exp = 6.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      JWT.decode(token, SECRET_KEY)[0]
    end

    def self.generate_payload(driver)
      {
        id: driver&.id,
        email: driver&.email
      }
    end
  end
end
