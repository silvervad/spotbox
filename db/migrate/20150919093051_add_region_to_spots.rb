class AddRegionToSpots < ActiveRecord::Migration
  def change
    add_reference :spots, :region, index: true
  end
end
