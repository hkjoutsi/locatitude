class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :requestor_id, index: true
      t.integer :requestee_id, index: true

      t.timestamps null: false
    end
  end
end
