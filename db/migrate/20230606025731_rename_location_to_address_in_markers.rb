class RenameLocationToAddressInMarkers < ActiveRecord::Migration[7.0]
  def change
    rename_column :markers, :location, :address
  end
end
