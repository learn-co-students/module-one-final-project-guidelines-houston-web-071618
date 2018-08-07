require_relative '../config/environment.rb'

class CommandLineInterface < ActiveRecord::Base

	def self.say_hello
		puts "Hello, welcome to HowMuchIsThatArtist.com"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "Please choose one of the following options: "
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	end

	def self.put_options
		puts "1. Get estimated cost by artist name."
		puts "2. View About Us."
		puts "3. View Contact Us"
		puts "4. View Legal"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "Enter choice number below:"
	end

	def self.get_user_input
		response = gets.chomp
		if self.does_user_want_to_quit(response)
			puts "SEE YA LATER ALLIGATOR!!!"
			exit
		else
			response
		end
	end

	def self.does_user_want_to_quit(input)
		input.downcase == "quit" || input.downcase == "exit"
	end

	def self.continue?
		puts "Would you like to continue?"
		puts "Enter 'yes' or 'no' below:"
		decision = self.get_user_input
		while decision != "no" && decision != "yes"
			puts "Please say 'yes' or 'no'."
			decision = self.get_user_input
		end

		if decision == "yes"
			system "clear"
			self.run
		elsif decision == "no"
			puts "Have a good day!"
		end
	end

	def self.run
		system "clear"
		self.say_hello
		self.put_options
		query_option = self.get_user_input.to_i

		while [1,2,3,4].exclude?(query_option)
			system "clear"
			puts "Sorry, that entry was not valid. Please enter a number 1-4"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			self.put_options
			query_option = self.get_user_input.to_i
		end

		if query_option == 1
			puts "Please enter an artist name -- no misspellings allowed."
			artist_name = self.get_user_input
			EstimateArtistCost.find_cost(artist_name)
		elsif query_option == 2
			puts "About Us Info Here"
		elsif query_option == 3
			puts "Contact Us Info Here"
		elsif query_option == 4
			puts "Legal Info Here"
		else
			puts "there was an error"
		end

		self.continue?

	end
end
