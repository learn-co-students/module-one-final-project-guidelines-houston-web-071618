require 'JSON'
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
						mbid: artist["mbid"]
				}
			end
		else 
			return "Error"
		end 
	end

	def self.get_top_artist_mbid_by_country(country)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=#{country}&api_key=#{api_details[:MY_KEY]}&format=json")

		parsed_country_hash = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_country_hash)

		if !contains_error 
			parsed_country_hash["topartists"]["artist"][0]["mbid"]
		else 
			return "Error"
		end 
	end

	def self.get_top_tracks_by_country(country)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=geo.gettoptracks&country=#{country}&api_key=#{api_details[:MY_KEY]}&format=json")

		parsed_tracks = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_tracks)

		if !contains_error 
			tracks_array = parsed_tracks["tracks"]["track"]
		
			tracks_array.map do |track_hash|
				{
						name: track_hash["name"],
						listeners: track_hash["listeners"],
						artist_mbid: track_hash["artist"]["mbid"],
						country_name: country
				}
			end
		else 
			return "Error"
		end 
	end
end