class AddAddressAndAttractionIdToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :address, :string
    add_column :activities, :attraction_id, :integer
  end
end
