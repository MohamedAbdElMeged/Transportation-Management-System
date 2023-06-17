module Api
  module V1
    class DriverSerializer
      include JSONAPI::Serializer
      attributes :id, :email
    end
  end
end
