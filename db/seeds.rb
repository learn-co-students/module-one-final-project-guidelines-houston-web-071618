# Artist.create(name: 'Beatles')
#
#   # def seed_songs
#   #   #run a loop for everything in the api
#   #   Song.create()
#   # end



  require "musix_match"

  MusixMatch::API::Base.api_key = "d8f358f97300518be509afbb7bcc131a"

  Category.create(title: "The Beatles") #category_id=1
  response = MusixMatch.search_track(:q_artist => 'The Beatles', :page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 19620101, f_track_release_group_first_release_date_max: 19700701 )
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:1})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first, artist_id:new_artist.id , category_id:1})
          end
        end
      end
    end
  end

  Category.create(title: "Justin Bieber") #category_id=2
  response = MusixMatch.search_track(:q_artist => 'Justin Bieber', :page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en')
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:2})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:2})
          end
        end
      end
    end
  end

  Category.create(title: "90's Pop") #category_id=3
  response = MusixMatch.search_track(:page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 19900101, f_track_release_group_first_release_date_max: 19991231 )
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:3})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:3})
          end
        end
      end
    end
  end

  Category.create(title: "2000's Pop") #category_id=4
  response = MusixMatch.search_track(:page_size => 50, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 20000101, f_track_release_group_first_release_date_max: 20091231 )
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:4})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:4})
          end
        end
      end
    end
  end

  Category.create(title: "Beyonce/Destiny's Child") #category_id=5
  response = MusixMatch.search_track(:q_artist => 'Beyonce', :page_size => 30, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 20030101)
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:5})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:5})
          end
        end
      end
    end
  end
  response = MusixMatch.search_track(:q_artist => "Destiny's Child", :page_size => 20, :f_has_lyrics => true, :s_track_rating => 'desc', f_lyrics_language: 'en', f_track_release_group_first_release_date_min: 19980101, f_track_release_group_first_release_date_max: 20041231)
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:desired_artist.id , category_id:5})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:5})
          end
        end
      end
    end
  end

  Category.create(title: "Today's Hits") #category_id=6
  response = MusixMatch.get_track_chart(:page_size => 50, :f_has_lyrics => true)
  if response.status_code == 200
    response.each do |track|
      lyric_response = MusixMatch.get_lyrics(track.track_id)
      if lyric_response.status_code == 200 && lyrics = lyric_response.lyrics
        if lyrics.lyrics_body != ""
          desired_lyrics=lyrics.lyrics_body.split("...")
          if Artist.all.pluck(:name).include?(track.artist_name)
            desired_artist = Artist.find_by(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first, artist_id:desired_artist.id , category_id:6})
          else
            new_artist = Artist.create(name: track.artist_name)
            Song.create({title: track.track_name , musix_match_track_id:track.track_id , lyrics:desired_lyrics.first , artist_id:new_artist.id , category_id:6})
          end
        end
      end
    end
  end
