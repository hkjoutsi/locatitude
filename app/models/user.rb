class User < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships
	
	#friendships with "pending" mean, that user has made the request
	#friendships with "requested" mean, that friend has made the request
	#has_many :pending_friendships, -> { where status: 'pending' }, class_name: 'Friendship'
	#has_many :pending_friends, through: :pending_friendships, source: :friend

	#the inverses are mainly for curiosity + possibly needed when destroying the user or setting possible blocks etc.?
	has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', dependent: :destroy
	has_many :inverse_friends, through: :inverse_friendships, source: :user
	has_many :friend_requestors, through: :inverse_friendships, source: :user#, status: 'pending'

	validates :username, presence: true

	def to_s
		return username
	end


end
