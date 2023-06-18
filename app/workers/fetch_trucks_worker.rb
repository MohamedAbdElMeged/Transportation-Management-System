class FetchTrucksWorker
  include Sidekiq::Worker
  sidekiq_options queue: :fetch_trucks_queue
  def perform
    response = Trucks::FetchNewTrucks.call
    if response.failure?
      REDIS.del('next_page')
      return
    end

    total_trucks_from_headers = response.response_headers&.[]('total-count')
    total_trucks_from_db = REDIS.get('total_trucks_count_in_db')
    while total_trucks_from_db.to_i < total_trucks_from_headers.to_i
      response = Trucks::FetchNewTrucks.call
      break if response.failure?

      total_trucks_from_db = REDIS.get('total_trucks_count_in_db')
    end
    REDIS.del('next_page')
  end
end
