class Truck < ApplicationRecord
  has_many :drivers_trucks, dependent: :destroy
  has_many :drivers, through: :drivers_trucks
end
