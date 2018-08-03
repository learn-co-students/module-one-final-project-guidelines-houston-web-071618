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
						mbid: artist["mbid"],
						listeners: artist["listeners"],
						cost: 0.105 * artist["listeners"].to_f + 1414
				}
			end
		else 
			return "Error"
		end 
	end

	def self.get_top_artists_by_country(country)
		api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=#{country}&api_key=#{api_details[:MY_KEY]}&format=json")

		parsed_countries = JSON.parse(api_data)

		contains_error = APIValidator.check_response(parsed_countries)

		if !contains_error 
			countries_artist_array = parsed_countries["topartists"]["artist"]
			
			countries_artist_array.map do |artist_hash|
				{
					country_name: country,
					top_artist_mbid: artist_hash["mbid"],
					artist_name: artist_hash["name"],
					listeners: artist_hash["listeners"]
				}
			end
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