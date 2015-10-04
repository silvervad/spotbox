class ChangeLatitudeAndLongitudeInSchools < ActiveRecord::Migration

  def up
    change_column :schools, :latitude, :decimal, precision: 10, scale: 6
    change_column :schools, :longitude, :decimal, precision: 10, scale: 6
  end

  def down
	  change_column :schools, :latitude, :decimal
	  change_column :schools, :longitude, :decimal
  end
end
