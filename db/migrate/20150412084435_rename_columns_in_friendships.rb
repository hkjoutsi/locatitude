class RenameColumnsInFriendships < ActiveRecord::Migration
  def change
  	rename_column :friendships, :requestor_id, :user_id
  	rename_column :friendships, :requestee_id, :friend_id
  end
end
