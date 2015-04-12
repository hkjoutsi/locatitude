class Location < ActiveRecord::Base
	belongs_to :user
	
	geocoded_by :address
	#sends a request to an external API (google maps by default?)
	after_validation :geocode, :if => :address_changed?

	#how does this work?
	reverse_geocoded_by :latitude, :longitude#, :address => :location
	after_validation :reverse_geocode#, :if => :longitude_changed?
	#after_validation :reverse_geocode, :if => :latitude_changed?

	#GEOCODING SHOULD PROBABLY BE DONE BY IPADDRESS OR THE LIKE?
	#behaviour of geocode in case of errors (e.g. address and longitude mismatch)
	#not totally clear -> some unexpected behaviour while testing

	validates :user, presence: true
	validate :address_xor_coordinates_must_be_given

	def address_xor_coordinates_must_be_given
		if address? && (longitude? || latitude?)
			errors[:base] << "Invalid location: Both address and coordinates cannot be given!"
		elsif !address? && (!latitude? || !longitude?)
			errors[:base] << "Invalid location: Either address or both coordinates has to be given!"
		end
	end

end
