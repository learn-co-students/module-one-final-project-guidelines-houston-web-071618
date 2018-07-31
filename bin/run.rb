require_relative '../config/environment'
require "pry"
require "musix_match"

MusixMatch::API::Base.api_key = 'd8f358f97300518be509afbb7bcc131a'

puts "HELLO WORLD"
response = MusixMatch.search_track(:q_artist => 'Arctic Monkeys')
if response.status_code == 200
  response.each do |track|
    puts "#{track.track_id}: #{track.track_name} (#{track.artist_name})"
  end
end
# binding.pry
# false
