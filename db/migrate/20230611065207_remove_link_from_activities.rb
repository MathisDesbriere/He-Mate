class RemoveLinkFromActivities < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :link, :string
  end
end
