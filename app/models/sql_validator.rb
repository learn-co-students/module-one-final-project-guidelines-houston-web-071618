class SQLValidator < ActiveRecord::Base
	def self.check_if_exists_in_artists(artist_name)
		Artist.find_by name: artist_name != nil
	end 
	
	def self.check_if_exists_in_tracks(track_name)
		Track.find_by name: track_name != nil
	end 
	
	def self.check_if_exists_in_countries(country_name)
		Country.find_by country_name: country_name != nil 
	end 
end 