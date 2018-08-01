require_relative '../config/environment.rb'
require 'JSON'
require 'rest-client'

# Artist.delete_all
# Country.delete_all
# Track.delete_all



def get_artists
    api = api_details[:MY_KEY]
    api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=#{api}&format=json")
    parsed_data = JSON.parse(api_data)
    all_artists = parsed_data["artists"]["artist"]

    all_artists.each do |artist_obj|
        artist = Artist.new()
        artist.name = artist_obj["name"]
        artist.mbid = artist_obj["mbid"] 
        artist.save
    end
end

def get_countries
    api = api_details[:MY_KEY]
    countries_list = ["Argentina", "Australia", "Austria", "Belgium", "Brazil", "Canada", "China", "Czech Republic", "Denmark", "France", "Germany", "India", "Japan", "Mexico", "Netherlands", "New Zealand", "Norway", "South Africa", "Sweden", "Switzerland", "Spain", "United Kingdom", "United States"]

    countries_list.each do |country|
        api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=#{country}&api_key=#{api}&format=json")
        parsed_data = JSON.parse(api_data)
        
        new_country = Country.new()
        new_country.name = country
        new_country.top_artist_mbid = parsed_data["topartists"]["artist"][0]["mbid"]
        new_country.save
    end
end

def get_tracks
    api = api_details[:MY_KEY]
    countries_list = ["Argentina", "Australia", "Austria", "Belgium", "Brazil", "Canada", "China", "Czech Republic", "Denmark", "France", "Germany", "India", "Japan", "Mexico", "Netherlands", "New Zealand", "Norway", "South Africa", "Sweden", "Switzerland", "Spain", "United Kingdom", "United States"]

    countries_list.each do |country|
        api_data = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=geo.gettoptracks&country=#{country}&api_key=#{api}&format=json")
        parsed_data = JSON.parse(api_data)
        all_tracks = parsed_data["tracks"]["track"]

        all_tracks.each do |track_obj|
            track = Track.new()
            track.name = track_obj["name"]
            track.listeners = track_obj["listeners"]
            track.artist_mbid = track_obj["artist"]["mbid"]
            track.country_name = country
            track.save 
        end
    end
end

get_tracks
get_artists
get_countries