class CreateDriversTrucks < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers_trucks do |t|
      t.belongs_to :driver
      t.belongs_to :truck
      t.datetime :assigned_at
      t.timestamps
    end
  end
end
