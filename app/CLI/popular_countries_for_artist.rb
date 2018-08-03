require_relative '../../config/environment'

class PopularCountriesForArtist
  def self.countries_where_artist_is_most_popular(artist_name)
    if CommandLineInterface.does_artist_exist(artist_name)
      artist_object = Artist.find_by name: artist_name 
      artist_mbid = artist_object.mbid

      country_array = Country.where(top_artist_mbid: artist_mbid) #array of country objects where artist is
      #popular 

      if country_array.count == 0
        puts "Sorry the artist isn't popular anywhere!!"
      else
        puts country_array.map {|country| country.country_name}
      end
    else
      puts "Sorry that artist doesn't exist"
    end
  end

  def self.run_option_two
    puts "Please enter an artist's name - no misspellings allowed."
    artist_name = CommandLineInterface.get_user_input 
    self.countries_where_artist_is_most_popular(artist_name)
  end
end