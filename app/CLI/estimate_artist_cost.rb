class EstimateArtistCost
  def self.find_cost(artist_name)
    
    if CommandLineInterface.does_artist_exist(artist_name)
      artist_obj = Artist.find_by name: artist_name
      
      if artist_obj["cost"] == nil
        artist_obj["cost"] = 0.105 * artist["listeners"].to_f + 1414
      end
    else
      api_result = LastFMApi.get_artist_info_from_api(artist_name)
      
      if api_result != "Error"
        artist_obj = Artist.create(api_result)
      end
    end
  
    formatted = "$" + artist_obj["cost"].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
    
    puts formatted
  end
  
  def self.run_option_four
    puts "Please enter an artist name -- no misspellings allowed."
    artist_name = CommandLineInterface.get_user_input
    self.find_cost(artist_name)
  end
end