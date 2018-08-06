require_relative '../config/environment.rb'
require 'json'
require 'rest-client'

Artist.delete_all
Track.delete_all

def seed_artists
	all_artists = LastFMApi.get_artists_array

	all_artists.each do |artist_hash|
		new_artist = Artist.first_or_create(artist_hash)
		Valuator.add_cost_data(new_artist)
	end
end

def seed_tracks(artist_array)
	artist_array.each do |artist_hash|
		top_tracks_array = LastFMApi.get_top_tracks_by_artist(artist_hash)

		top_tracks_array.each do |track_hash|
			Track.first_or_create(track_hash)
		end
	end
end

seed_tracks(artist_array)
seed_artists
