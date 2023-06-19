module Trucks
  class FetchNewTrucks
    include Interactor::Organizer
    before :set_headers
    organize SetParams, ConstructUrl, RequestTrucks, SetNextPage, SaveNewTrucks

    def set_headers
      context.request_headers = {
        "API_KEY": ENV['TRUCK_API_KEY']
      }
    end
  end
end
