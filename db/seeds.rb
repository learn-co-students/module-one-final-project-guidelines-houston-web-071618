require_relative '../config/environment.rb'
require 'json'
require 'rest-client'
require 'csv'

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

def artists_from_csv
	CSV.foreach('./db/enriched_artist_data.csv', headers: true) do |row|
		# x = encode_text(row["bio_intro"])
		# binding.pry
		Artist.create({
			name: row["corrected_band_name"],
			mbid: row["mbid"],
			listeners: row["listeners"],
	    cost: row["average_price"],
	    wikipedia_bio_intro: row["bio_intro"],
	    actual_known_cost?: row["actual_known_cost?"],
	    image_url: row["image_url"]
		})
	end
end

def encode_text(text)
	text.class == String ? text.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '') : text
end

artists_from_csv
# seed_tracks(artist_array)
# seed_artists
