class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
