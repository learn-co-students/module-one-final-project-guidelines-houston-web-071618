require_relative '../config/environment'
require "pry"
require "musix_match"

MusixMatch::API::Base.api_key = 'd8f358f97300518be509afbb7bcc131a'

puts "HELLO WORLD"
response = MusixMatch.search_track(:q_artist => 'Beatles', :page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc' )
if response.status_code == 200
  response.each do |track|

    puts "#{track.track_id}: #{track.track_name} (#{track.artist_name})"
    puts "Lyrics id: #{track.lyrics_id}"
  end
end

response = MusixMatch.get_lyrics('3799553')
if response.status_code == 200 && lyrics = response.lyrics
  puts lyrics.lyrics_body[0..100]
  #binding.pry
end

response = MusixMatch.get_lyrics('3799553')
if response.status_code == 200 && lyrics = response.lyrics
  puts lyrics.lyrics_body[0..100]
  #binding.pry
end
 binding.pry
# false
