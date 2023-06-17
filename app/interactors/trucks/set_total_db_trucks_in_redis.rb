module Trucks
  class SetTotalDbTrucksInRedis
    include Interactor
    def call
      save_total_db_trucks_in_redis
    end

    private

    def save_total_db_trucks_in_redis
      trucks_count = Truck.all.size
      REDIS.set('total_trucks_count_in_db', trucks_count)
    end
  end
end
