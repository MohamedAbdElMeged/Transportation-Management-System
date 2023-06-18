class Truck < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :drivers_trucks, dependent: :destroy
  has_many :drivers, through: :drivers_trucks

  after_destroy :decrement_total_trucks_in_redis
  def decrement_total_trucks_in_redis
    REDIS.decr('total_trucks_count_in_db')
  end
end
