class RemovePictureFromActivities < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :picture, :string
  end
end
