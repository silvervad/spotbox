class AddIndexToRegionsName < ActiveRecord::Migration
  def change
    add_index :regions, :name, unique: true
  end
end
