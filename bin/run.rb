require_relative '../config/environment'
require "pry"
require "musix_match"

MusixMatch::API::Base.api_key = "d8f358f97300518be509afbb7bcc131a"

# response = MusixMatch.search_track(:q_artist => 'The Beatles', :page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 19620101, f_track_release_group_first_release_date_max: 19700701 )
# if response.status_code == 200
#   response.each do |track|
#     #binding.pry
#     lyric_response = MusixMatch.get_lyrics(track.track_id)
#     if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
#       # Song.new(title: track.track_name , usix_match_track_id:track.track_id , lyrics:lyrics.lyrics_body , artist_id:1 , category_id:1)
#       puts "#{track.track_id}: #{track.track_name} (#{track.artist_name})"
#       #puts "#{lyrics.lyrics_body[0..50]}"
#     end
#   end
# end
count = 0

new_cli = CommandLineInterface.new
new_cli.run

# response = MusixMatch.get_track_chart(:page_size => 50, :f_has_lyrics => true)
# if response.status_code == 200
#   response.each do |track|
#     lyric_response = MusixMatch.get_lyrics(track.track_id)
#     if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
#       if lyrics.lyrics_body != ""
#         blah=lyrics.lyrics_body.split("...")
#         count+=1
#         puts "*******************************************************************************************************"
#         puts "#{track.track_id}: #{track.track_name} (#{track.artist_name})"
#         puts "#{blah.first}"
#         puts "*******************************************************************************************************"
#       end
#     end
#   end
# end

# response = MusixMatch.get_lyrics('3799553')
# if response.status_code == 200 && lyrics = response.lyrics
#   puts lyrics.lyrics_body
#   #binding.pry
# end
#
# response = MusixMatch.get_lyrics('3799553')
# if response.status_code == 200 && lyrics = response.lyrics
#   puts lyrics.lyrics_body[0..100]
#   #binding.pry
# end
#
# response = MusixMatch.get_track_chart(:page_size => 50)
# if response.status_code == 200
#   response.each do |track|
#     puts "#{track.track_id}: #{track.track_name} (#{track.artist_name})"
#   end
# end
 #binding.pry
# false
