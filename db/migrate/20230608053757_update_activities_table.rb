class UpdateActivitiesTable < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :trip_id, :integer, null: true
  end
end
