require 'json'
require 'rest-client'
require_relative '../../config.rb'


class LastFMApi

	def self.get_single_artist_name_by_mbid(artist_mbid)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&mbid=#{artist_mbid}&api_key=#{api_details[:MY_KEY]}&format=json")
		parsed_data = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_data)

		if !contains_error
			parsed_data["artist"]["name"]
		else
			return "Error"
		end
	end

	def self.get_artists_array
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=#{api_details[:MY_KEY]}&format=json")
		parsed_data = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_data)

		if !contains_error
			parsed_data["artists"]["artist"].map do | artist |
				{
					name: artist["name"],
					mbid: artist["mbid"],
					listeners: artist["listeners"]
				}
			end
		else
			return "Error"
		end
	end

	def self.get_top_tracks_by_artist(artist_hash)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{artist_hash[:name]}&api_key=#{api_details[:MY_KEY]}&format=json")

		parsed_tracks = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_tracks)

		if !contains_error
			tracks_array = parsed_tracks["toptracks"]["track"]

			tracks_array.map do |track_hash|
				{
					name: track_hash["name"],
					listeners: track_hash["listeners"],
					artist_id: artist_hash[:id]
				}
			end
		else
			return "Error"
		end
	end

	def self.get_artist_info_from_api(artist_name)
	  api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{artist_name}&api_key=#{api_details[:MY_KEY]}&format=json")
	  parsed_data = JSON.parse(api_data)
		artist = parsed_data["artist"]

		{
			name: artist["name"],
			mbid: artist["mbid"],
			listeners: artist["listeners"]
		}
	end

	def self.get_similar_artists(artist_name)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist=#{artist_name}&api_key=#{api_details[:MY_KEY]}&format=json")
		parsed_data = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_data)

		if !contains_error
			artists_array = parsed_data["similarartists"]["artist"]

			artists_array.map do |artist_hash|
				{
					#need to find or create arist here so can use DB ID to reference search artist and foreign artist
				}
			end
		end
	end
end
