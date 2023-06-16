class Driver < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :drivers_trucks, dependent: :destroy
  has_many :trucks, through: :drivers_trucks
end
