class Truck < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :drivers_trucks, dependent: :destroy
  has_many :drivers, through: :drivers_trucks
end
