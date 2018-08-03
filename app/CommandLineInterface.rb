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

	# def self.get_artist_mbid_by_new_country(country_name)
	# 
	# 	top_artist_mbid_string = LastFMApi.get_top_artists_by_country(country_name)
	# 	binding.pry
	# 	if top_artist_mbid_string == "Error"
	# 		"Error"
	# 	else
	# 		if !self.does_country_exist(country_name)
	# 			Country.create(name: country_name, top_artist_mbid: top_artist_mbid_string)
	# 
	# 			top_artist_name = LastFMApi.get_single_artist_name_by_mbid(top_artist_mbid_string)
	# 
	# 			if !self.does_artist_exist(top_artist_name)
	# 				Artist.create(name: top_artist_name, mbid: top_artist_mbid_string)
	# 			end
	# 
	# 			top_artist_name
	# 		end
	# 	end 
	# end

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

	

	def self.find_artist_name_by_mbid(artist_mbid)
		artist_object = Artist.find_by mbid: artist_mbid 

		if artist_object 
			artist_object.name
		else 
			"Unknown"
		end
	end

	def self.does_artist_exist(artist_name)
		Artist.exists? name: artist_name
	end 

	def self.does_country_exist(country)
		Country.exists? country_name: country 
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
			PopularArtistsByCountry.run_option_one 
		elsif query_option == 2
			PopularCountriesForArtist.run_option_two
		elsif query_option == 3
			PopularTracksByCountry.run_option_three
		else
			puts "there was an error"
		end

		continue?

			# if self.does_artist_exist(reply)
			#     #run successful here
			# end

	end
end