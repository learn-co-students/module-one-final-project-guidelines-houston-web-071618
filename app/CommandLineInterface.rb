class CommandLineInterface < ActiveRecord::Base

    def self.say_hello
        puts "Hello, welcome to Artist Info CLI"
        puts "Please choose one of the following options: "
    end 

    def self.put_options
        puts "1. Most popular artist for a given country."
        puts "2. Most popular country for a given artist."
        puts "3. Most popular tracks for a given country"
        # puts "4. How much is artist worth for a given market."
    end 

    def self.get_user_input
        gets.chomp
    end 

    def self.top_artist_in_given_country(country)
        country_object = Country.find_by name: country
        artist_mbid = country_object.top_artist_mbid 

        puts self.find_artist_name_by_mbid(artist_mbid)
    end

    def self.find_artist_name_by_mbid(artist_mbid)
        artist_object = Artist.find_by mbid: artist_mbid 
        if artist_object 
            artist_object.name
        else "Unknown"
        end
    end

    def self.top_tracks_in_given_country(country)
        track_obj_array = Track.where country_name: country
        
        track_obj_array.map do |track_obj| 
            track_listeners = track_obj.listeners.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
            track_artist = self.find_artist_name_by_mbid(track_obj.artist_mbid)
            # binding.pry

            puts "TRACK NAME: #{track_obj.name}  ||  LISTENERS: #{track_listeners}  ||  ARTIST: (#{track_artist})"

            #{track_obj.listeners.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse} (#{self.find_artist_name_by_mbid(track_obj.artist_mbid)})"
            # self.find_artist_name_by_mbid(
        end
    end

    def self.countries_where_artist_is_most_popular(artist_name)
        artist_object = Artist.find_by name: artist_name 
        artist_mbid = artist_object.mbid

        country_array = Country.where(top_artist_mbid: artist_mbid) #array of country objects where artist is
        #popular 

        puts country_array.map {|country| country.name}
    end


    def self.does_artist_exist(artist_name)
        Artist.exists? name: artist_name
    end 

    def self.continue?
        puts "Would you like to continue?"
        decision = self.get_user_input
        while decision != "no" && decision != "yes"
            puts "Please say 'yes' or 'no'."
            decision = self.get_user_input
        end

        if decision == "yes"
            self.run
        elsif decision == "no"
            puts "Have a good day!" 
        end 

    end 

    def self.run
        self.say_hello
        self.put_options
        query_option = self.get_user_input.to_i
         
        while [1,2,3].exclude?(query_option)
            puts "Sorry, that entry was not valid. Please enter a number 1-3"
            self.put_options
            query_option = self.get_user_input
        end
    
        if query_option == 1
            puts "Please enter a country name - no misspellings allowed."
            country = self.get_user_input
            self.top_artist_in_given_country(country)
        elsif query_option == 2
            puts "Please enter an artist's name - no misspellings allowed."
            artist_name = self.get_user_input 
            self.countries_where_artist_is_most_popular(artist_name)
            true
        elsif query_option == 3
            puts "Please enter a country name - no misspellings allowed."
            country = self.get_user_input 
            self.top_tracks_in_given_country(country)
        else
            puts "there was an error"
        end

        continue?

        # if self.does_artist_exist(reply)
        #     #run successful here
        # end

    end

end

