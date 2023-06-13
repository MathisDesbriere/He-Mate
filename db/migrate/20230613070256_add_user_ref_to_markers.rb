class AddUserRefToMarkers < ActiveRecord::Migration[7.0]
  def change
    add_reference :markers, :user, null: true, foreign_key: true
  end
end
