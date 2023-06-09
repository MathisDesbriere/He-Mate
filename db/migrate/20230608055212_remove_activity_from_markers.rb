class RemoveActivityFromMarkers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :markers, :activity, foreign_key: true
  end
end
