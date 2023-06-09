class AddActivityReferenceToMarkers < ActiveRecord::Migration[7.0]
  def change
    add_reference :markers, :activity, null: true, foreign_key: true
  end
end
