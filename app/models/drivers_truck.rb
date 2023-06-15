class DriversTruck < ApplicationRecord
  belongs_to :driver
  belongs_to :truck

  before_create :set_assigned_at

  def set_assigned_at
    self.assigned_at = DateTime.now
  end
end
