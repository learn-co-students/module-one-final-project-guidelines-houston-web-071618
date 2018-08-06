require_relative '../../config/environment'

class PopularTracksByCountry
  def self.top_tracks_in_given_country(country)
    track_obj_array = Track.where country_name: country
    
    if track_obj_array.length == 0
      new_tracks_obj_array = LastFMApi.get_top_tracks_by_country(country)

      if new_tracks_obj_array == "Error"
        return "Could not find from Last FM"
      else
        new_tracks_obj_array.map do |track_hash|
          Track.create(track_hash)
        end
      end
    end

    x = Track.where(country_name: country).order('listeners DESC')
    
    results = x.first(10)
    
    puts "+++++++++++++++++++++++++++++++++++++++++"
    puts "#{country}'s most popular tracks are:"
    
    results.map do |track_obj| 
      track_listeners = track_obj[:listeners].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
      track_artist = CommandLineInterface.find_artist_name_by_mbid    (track_obj[:artist_mbid])
    
      puts "TRACK NAME: #{track_obj[:name]}  ||  LISTENERS:   #{track_listeners}  ||  ARTIST: (#{track_artist})"
    end
  end

  def self.run_option_three
    puts "Please enter a country name - no misspellings allowed."
    country = CommandLineInterface.get_user_input 
    self.top_tracks_in_given_country(country)
  end
end