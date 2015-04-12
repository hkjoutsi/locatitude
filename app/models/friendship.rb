class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: 'User'

	validates :user, presence: true
	validates :friend, presence: true
	#status column inficates if this is yet a request and from whom, or if it's a confirmed or rejected friendship
	validates_inclusion_of :status, presence: true, in: %w( pending requested accepted rejected)
	#validate :friendship_must_be_unique
	validates_uniqueness_of :friend_id, scope: :user_id
	#validates_uniqueness_of :user_id, scope: :friend_id #THIS INS'T NECESSARY
	validate :cannot_be_friends_with_self

	scope :pending, -> {where status: 'pending'}
	scope :requested, -> {where status: 'requested'}
	scope :accepted, -> {where status: 'accepted'}
	scope :rejected, -> {where status: 'rejected'}



	# def friendship_must_be_unique #this needs to be polished, because if only one of these exists -> something is broken
 # 		if Friendship.where(user: user).where(friend: friend).any? || Friendship.where(user: friend).where(friend: user).any?
	# 		errors[:base] << "Invalid friendship: these users are already friends! A friendship must be unique."
 #    	end
	# end

	def cannot_be_friends_with_self
		if user == friend
			errors.add(:user, "cannot be friends with self")
		end
	end

end
