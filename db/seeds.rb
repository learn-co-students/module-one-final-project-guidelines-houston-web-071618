require_relative '../config/environment.rb'
require 'JSON'
require 'rest-client'

Artist.delete_all
Country.delete_all
Track.delete_all

seed_countries_list = ["Argentina", "Australia", "Austria", "Belgium", "Brazil", "Canada", "China", "Czech Republic", "Denmark", "France", "Germany", "India", "Japan", "Mexico", "Netherlands", "New Zealand", "Norway", "South Africa", "Sweden", "Switzerland", "Spain", "United Kingdom", "United States"]

def seed_artists
	all_artists = LastFMApi.get_artists_array

	all_artists.each do |artist_hash|
		Artist.create(artist_hash)
	end
end

def seed_countries(seed_countries_list)

	seed_countries_list.each do |country|
		top_artist_mbid_string = LastFMApi.get_top_artist_mbid_by_country(country)

		Country.create(name: country, top_artist_mbid: top_artist_mbid_string)
	end
end

def seed_tracks(seed_countries_list)
	seed_countries_list.each do |country|
		top_tracks_array = LastFMApi.get_top_tracks_by_country(country)

		top_tracks_array.each do |track_hash|
			Track.create(track_hash)
		end
	end		
end

seed_tracks(seed_countries_list)
seed_artists
seed_countries(seed_countries_list)