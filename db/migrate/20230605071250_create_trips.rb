class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.integer :like, default: 0
      t.text :description

      t.timestamps
    end
  end
end
