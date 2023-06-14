class AddUsersToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :creator, null: false, foreign_key: { to_table: :users }
    add_reference :chatrooms, :participant, null: false, foreign_key: { to_table: :users }
  end
end
