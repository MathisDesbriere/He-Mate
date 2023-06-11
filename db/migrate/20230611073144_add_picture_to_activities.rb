class AddPictureToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :picture, :string
  end
end
