class CreateFollowJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table 'follows' do |t|
      t.integer 'following_id', null: false, foreign_key: {to_table: :users}
      t.integer 'follower_id', null: false, foreign_key: {to_table: :users}

      t.timestamps null: false
    end
  end
end
