class AddMarkerToActivity < ActiveRecord::Migration[7.0]
  def change
    add_reference :activities, :marker, foreign_key: true
  end
end
