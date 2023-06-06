class CreateMarkers < ActiveRecord::Migration[7.0]
  def change
    create_table :markers do |t|
      t.float :longitude
      t.float :latitude
      t.references :trip, null: false, foreign_key: true
      t.string :location

      t.timestamps
    end
  end
end
