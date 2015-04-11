class User < ActiveRecord::Base
	has_many :locations, dependent: :destroy
	has_many :friendships, dependent: :destroy
	#will this work?
	has_many :friends, -> { uniq }, through: :friendships, source: :user

	validates :username, presence: true

	def to_s
		return username
	end
end
