class EstimateArtistCost
  def self.find_cost(artist_name)

    if CommandLineInterface.does_artist_exist(artist_name)
      artist_hash = Artist.find_by name: artist_name

      if artist_hash["cost"] == nil
        Valuator.add_cost_data(artist_hash)
      end
    else
      api_result = LastFMApi.get_artist_info_from_api(artist_name)

      if api_result != "Error"
        artist_hash = Artist.create(api_result)
      end
    end

    formatted = "$" + artist_hash["cost"].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse

    puts formatted
  end
end
