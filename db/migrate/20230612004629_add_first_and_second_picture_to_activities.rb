class AddFirstAndSecondPictureToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :first_picture, :string
    add_column :activities, :second_picture, :string
  end
end
