class UpdateMarkersTable < ActiveRecord::Migration[7.0]
  def change
    change_column :markers, :trip_id, :integer, null: true
  end
end
