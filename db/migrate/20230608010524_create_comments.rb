class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :like
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
