require "musix_match"
require_relative "../lib/seeding_automation.rb"

MusixMatch::API::Base.api_key = ""

beatles_hash ={
  :q_artist => 'The Beatles',
  :page_size => 50,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en',
  f_track_release_group_first_release_date_min: 19620101,
  f_track_release_group_first_release_date_max: 19700701
}

bieber_hash={
  :q_artist => 'Justin Bieber',
  :page_size => 50,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en'
}

90_pop_hash={
  :page_size => 50,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en',
  f_track_release_group_first_release_date_min: 19900101,
  f_track_release_group_first_release_date_max: 19991231
}

2000_pop_hash={
  :page_size => 50,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en',
  f_track_release_group_first_release_date_min: 20000101,
  f_track_release_group_first_release_date_max: 20091231
}

todays_hits={
  :page_size => 50,
  :f_has_lyrics => true
}

beyonce_hash={
  :q_artist => 'Beyonce',
  :page_size => 30,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en',
  f_track_release_group_first_release_date_min: 20030101
}

destinys_hash={
  :q_artist => "Destiny's Child",
  :page_size => 20,
  :f_has_lyrics => true,
  :s_track_rating => 'desc',
  f_lyrics_language: 'en',
  f_track_release_group_first_release_date_min: 19980101,
  f_track_release_group_first_release_date_max: 20041231
}

seed_musixmatch_data_artist('The Beatles' , [beatles_hash])
seed_musixmatch_data_artist('Justin Bieber' , [bieber_hash])
seed_musixmatch_data_artist("90's Pop" , [90_pop_hash])
seed_musixmatch_data_artist("2000's Pop" , [2000_pop_hash])
seed_musixmatch_data_artist("Beyonce/Destiny's Child" , [beyonce_hash,destinys_hash])
seed_musixmatch_data_chart("Today's Hits", [todays_hits])
