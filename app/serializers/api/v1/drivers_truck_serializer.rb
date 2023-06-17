module Api
  module V1
    class DriversTruckSerializer
      include JSONAPI::Serializer
      attributes :id, :assigned_at
      attribute :driver, if: proc { |_record, assigned_api|
        assigned_api ? false : true
      } do |object|
        DriverSerializer.new(object.driver)
      end

      attribute :truck do |object|
        TruckSerializer.new(object.truck)
      end
    end
  end
end
