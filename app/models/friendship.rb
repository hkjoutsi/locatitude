class Friendship < ActiveRecord::Base
	belongs_to :requestor, class_name: "User"
	belongs_to :requestee, class_name: "User"

	validates :requestor, presence: true
	validates :requestee, presence: true
	validate :friendship_must_be_unique
	validate :cannot_be_friends_with_self

	def friendship_must_be_unique
 		if Friendship.where(requestor: requestor).where(requestee: requestee).any? || Friendship.where(requestor: requestee).where(requestee: requestor).any?
			errors.add(:requestor, "User #{requestor} (id: #{requestor.id}) is already friends with user #{requestee} (id: #{requestee.id})")
    	end
	end

	def cannot_be_friends_with_self
		if requestee == requestor
			errors.add(:requestee, "cannot be friends with self")
		end
	end

end
