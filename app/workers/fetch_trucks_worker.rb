class FetchTrucksWorker
  inculde Sidekiq::Worker
  def perform
    response = Trucks::FetchNewTrucks.call
    return if response.failure?

    total_trucks_from_headers = response.response_headers&.[]('total-count')
    total_trucks_from_db = REDIS.get('total_trucks_count_in_db')
    while total_trucks_from_db.to_i < total_trucks_from_headers.to_i
      Trucks::FetchNewTrucks.call
      total_trucks_from_db = REDIS.get('total_trucks_count_in_db')
    end
  end
end
