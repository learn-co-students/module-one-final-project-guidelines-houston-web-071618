require_relative '../../config/environment'

class PopularArtistsByCountry
  # def self.get_new_artist_name_by_mbid(artist_mbid)
  #   new_artist_name = LastFMApi.get_single_artist_name_by_mbid(artist_mbid)
  # 
  #   binding.pry
  #   if new_artist_name == "Error"
  #     puts "Artist not found :("
  #   else
  #     if !self.does_artist_exist(new_artist_name)
  #       Artist.create(name: new_artist_name, mbid: artist_mbid)
  #     end
  #   end 
  # 
  #   new_artist_name
  # end
  
  def self.top_artists_in_given_country(country)
    country_object = Country.find_by country_name: country
    
    if country_object == nil  
      new_artist_array = LastFMApi.get_top_artists_by_country(country)
      
      if new_artist_array == "Error"
        return "Could not find from Last FM."
      else
        new_artist_array.map do |artist_hash|
          Country.create(artist_hash) #
        end 
      end
    end 
    
    x = Country.where(country_name: country).order('listeners DESC')

    results = x.first(10)
    
    puts "+++++++++++++++++++++++++++++++++++++++++"
    puts "#{country}'s most popular artists are:"
    
    results.map do |country_hash|
      name = country_hash["artist_name"]
      listeners = country_hash["listeners"].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
      
      puts "ARTIST NAME: #{name} || LISTENERS: #{listeners}"
    end
  end

  def self.run_option_one
    puts "Please enter a country name - no misspellings allowed."
    country = CommandLineInterface.get_user_input
    answer = self.top_artists_in_given_country(country)
  end
end

# get input
# check db for country
  # if db country yes, then return artist
  # if db country no, then search last fm api by country
    # if last fm api yes, create new country & return artist name
    # if last fm api no, return error
    