class Location < ActiveRecord::Base
	belongs_to :user
	
	geocoded_by :address
	#sends a request to an external API (google maps by default?)
	after_validation :geocode, :if => :address_changed?

	#how does this work?
	reverse_geocoded_by :latitude, :longitude#, :address => :location
	after_validation :reverse_geocode#, :if => :longitude_changed?
	#after_validation :reverse_geocode, :if => :latitude_changed?
end
