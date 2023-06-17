module Api
  module V1
    class TruckSerializer
      include JSONAPI::Serializer
      attributes :id, :name, :truck_type
    end
  end
end
