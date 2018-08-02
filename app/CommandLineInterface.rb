require_relative '../config/environment.rb'

class CommandLineInterface < ActiveRecord::Base

	def self.say_hello
		puts "Hello, welcome to Artist Info CLI"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "Please choose one of the following options: "
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	end 

	def self.put_options
		puts "1. Most popular artist for a given country."
		puts "2. Most popular country for a given artist."
		puts "3. Most popular tracks for a given country"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "Enter choice number below:"
	end 

	def self.get_user_input
		response = gets.chomp.downcase.capitalize
		if self.does_user_want_to_quit(response)
			puts "SEE YA LATER ALLIGATOR!!!"
			exit 
		else
			response
		end 
	end 

	def self.does_user_want_to_quit(input)
		input == "Quit" || input == "Exit"
	end

	def self.get_new_artist_name_by_mbid(artist_mbid)
		new_artist_name = LastFMApi.get_single_artist_name_by_mbid(artist_mbid)

		if new_artist_name == "Error"
			puts "Artist not found :("
		else
			if !self.does_artist_exist(new_artist_name)
				Artist.create(name: new_artist_name, mbid: artist_mbid)
			end
		end 

		new_artist_name
	end

	def self.get_artist_by_new_country(country_name)

		top_artist_mbid_string = LastFMApi.get_top_artist_mbid_by_country(country_name)
		if top_artist_mbid_string == "Error"
			"Error"
		else
			if !self.does_country_exist(country_name)
				Country.create(name: country_name, top_artist_mbid: top_artist_mbid_string)

				top_artist_name = LastFMApi.get_single_artist_name_by_mbid(top_artist_mbid_string)

				if !self.does_artist_exist(top_artist_name)
					Artist.create(name: top_artist_name, mbid: artist_mbid)
				end

				top_artist_name
			end
		end 
	end

	def self.get_tracks_by_new_country(country)
		top_tracks_array = LastFMApi.get_top_tracks_by_country(country)

		if top_tracks_array == "Error"
			puts "Error"
		else 
			top_tracks_array.each do |track_hash|
				Track.create(track_hash)
			end
		end 
	end 

	def self.top_artist_in_given_country(country)

		country_object = Country.find_by name: country

		if country_object == nil 
			new_artist_mbid = self.get_artist_by_new_country(country)
			if new_artist_mbid == "Error"
				puts "Could not find from database."
			else 
				puts self.get_new_artist_name_by_mbid(new_artist_mbid)
			end 
		else 
			artist_mbid = country_object.top_artist_mbid 
		end

		self.find_artist_name_by_mbid(artist_mbid)
	end

	def self.find_artist_name_by_mbid(artist_mbid)
		artist_object = Artist.find_by mbid: artist_mbid 

		if artist_object 
			artist_object.name
		else 
			"Unknown"
		end
	end

	def self.top_tracks_in_given_country(country)
		track_obj_array = Track.where country_name: country
		if track_obj_array.length == 0
			new_tracks_obj_array = LastFMApi.get_top_tracks_by_country(country)

			if new_tracks_obj_array == "Error"
				puts "No tracks found"
			else
				new_tracks_obj_array.map do |track_hash|
					Track.create(track_hash)
				end

				track_obj_array = new_tracks_obj_array
			end
		end
		
		# binding.pry
		if track_obj_array != "Error"
			track_obj_array.map do |track_obj| 
				track_listeners = track_obj[:listeners].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
				track_artist = self.find_artist_name_by_mbid    (track_obj[:artist_mbid])
			
				puts "TRACK NAME: #{track_obj[:name]}  ||  LISTENERS:   #{track_listeners}  ||  ARTIST: (#{track_artist})"
			end
		end
	end

	def self.countries_where_artist_is_most_popular(artist_name)
		if self.does_artist_exist(artist_name)
			artist_object = Artist.find_by name: artist_name 
			artist_mbid = artist_object.mbid

			country_array = Country.where(top_artist_mbid: artist_mbid) #array of country objects where artist is
			#popular 

			if country_array.count == 0
				puts "Sorry the artist isn't popular anywhere!!"
			else
				puts country_array.map {|country| country.name}
			end
		else
			puts "Sorry that artist doesn't exist"
		end
	end

	def self.does_artist_exist(artist_name)
		Artist.exists? name: artist_name
	end 

	def self.does_country_exist(country)
		Country.exists? name: country 
	end 

	def self.continue?
		#sleep(3.seconds)
		#system "clear"
		puts "Would you like to continue?"
		puts "Enter 'yes' or 'no' below:"
		decision = self.get_user_input
		while decision != "No" && decision != "Yes"
			puts "Please say 'yes' or 'no'."
			decision = self.get_user_input
		end

		if decision == "Yes"
			system "clear"
			self.run
		elsif decision == "No"
			puts "Have a good day!" 
		end 
	end 

	def self.option_one
    puts "Please enter a country name - no misspellings allowed."
		country = self.get_user_input
		answer = self.top_artist_in_given_country(country)
		if answer != "Unknown"
			puts "+++++++++++++++++++++++++++++++++++++++++"
			puts "#{country}'s most popular artist is: #{answer}"
		end 
	end

	def self.option_two
    puts "Please enter an artist's name - no misspellings allowed."
		artist_name = self.get_user_input 
		self.countries_where_artist_is_most_popular(artist_name)
	end

	def self.option_three
    puts "Please enter a country name - no misspellings allowed."
		country = self.get_user_input 
		self.top_tracks_in_given_country(country)
	end

	def self.run
		system "clear"
		self.say_hello
		self.put_options
		query_option = self.get_user_input.to_i
			
		while [1,2,3].exclude?(query_option)
			system "clear"
			puts "Sorry, that entry was not valid. Please enter a number 1-3"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			self.put_options
			query_option = self.get_user_input.to_i
		end

		if query_option == 1
			self.option_one 
		elsif query_option == 2
			self.option_two
		elsif query_option == 3
			self.option_three
		else
			puts "there was an error"
		end

		continue?

			# if self.does_artist_exist(reply)
			#     #run successful here
			# end

	end
end