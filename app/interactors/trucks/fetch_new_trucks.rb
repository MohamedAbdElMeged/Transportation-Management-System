module Trucks
  class FetchNewTrucks
    include Interactor::Organizer
    before :set_headers
    organize SetParams, EditUrl, RequestTrucks, SetNextPage, SaveNewTrucks, SetTotalDbTrucksInRedis

    def set_headers
      context.request_headers = {
        "API_KEY": ENV['TRUCK_API_KEY']
      }
    end
  end
end
