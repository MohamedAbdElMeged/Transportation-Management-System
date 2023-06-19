class FetchTrucksWorker
  include Sidekiq::Worker
  sidekiq_options queue: :fetch_trucks_queue
  def perform
    response = Trucks::FetchNewTrucks.call
    if response.failure?
      REDIS.del('next_page')
      return
    end
    until response.last_page
      response = Trucks::FetchNewTrucks.call
      break if response.failure?
    end
    REDIS.del('next_page')
  end
end
