class CommandLineInterface

  @@score = 0

  def show_high_score
    stars
    puts "    High Score : #{HighScore.first.high_score}"
    stars
  end

  def greet
    puts "\nWelcome to Lyrics Trivia, get ready to test your music knowledge!\n\nLet's play.\n\nEnter a number (1-6) based on the following options:\n1) The Beatles\n2) Justin Bieber\n3) Beyonce/Destiny's Child\n4) Today's Hits\n5) 2000's Pop\n6) 90's Pop\n\n"
  end

  def gets_user_input
    gets.chomp
  end


  def find_category(input)
    case input
    when "1"
      category_input= "The Beatles"
    when "2"
      category_input= "Justin Bieber"
    when "3"
      category_input= "Beyonce/Destiny's Child"
    when "4"
      category_input= "Today's Hits"
    when "5"
      category_input= "2000's Pop"
    when "6"
      category_input= "90's Pop"
    else
      category_input= "blah"
    end

    if Category.find_by(title: category_input) == nil
      puts "Sorry, that option is not available yet. Please try again from the options given."
      input = gets_user_input
      find_category(input)
    else
      Category.find_by(title: category_input)
    end
  end

  def hint_calculator(string:lyrics_title, number_divided_by:num)
      parsed_song = string.split(' (')
      parsed_song = parsed_song.first
      total_length = parsed_song.length
      desired_string_length=total_length/number_divided_by
      parsed_song[0...desired_string_length]
  end

  def get_lyrics(categ)
    selection = Song.select do |song|
      categ.id == song.category_id
    end
    song_out=selection.sample
    if !(song_out.lyrics.length >200)
      get_lyrics(categ)
    else
      song_out
    end
  end

  def show_lyrics(game_song)
    puts "\nHere's some lyrics:"
    stars
    puts "#{game_song.lyrics[0..100].colorize(:yellow)}\n"
    stars
  end

  def prompt_answer_or_hint
    puts "1) To guess the song now select 1.\n2) To get more lyrics select 2. NOTE: this option is a 5 point penalty to your potential increase.\n"
    while user_input = gets.chomp
     case user_input
     when "1"
       return 1
     when "2"
       return 2
     else
       puts "Please select either 1 or 2"
     end
    end
  end

  def prompt_answer_or_hint_title(song)
    puts "1) To guess the song select 1. \n2) To get part of the song title select 2. NOTE: this option is an additional 3 point penalty to your potential increase.\n"
    while user_input = gets.chomp
     case user_input
     when "1"
       break
     when "2"
       @@hint += 3
       stars
       puts "#{hint_calculator(string:song.title, number_divided_by:2)}\n"
       stars
       break
     else
       puts "Please select either 1 or 2"
     end
    end
  end

  def show_all_lyrics(song)
    @@hint += 5
    stars
    puts "\n#{song.lyrics.colorize(:yellow)}\n"
    stars
  end

  def prompt_answer
    puts "\nPlease type your answer:\n"
  end

  def compare_answer(answer, song)
    parsed_song = song.title.split(' (')
    parsed_song = parsed_song.first
    if parsed_song.downcase == answer.downcase
      puts "\nCongrats! You got it right!\nAnswer is: \n#{parsed_song.colorize(:yellow)} - #{song.artist.name.colorize(:yellow)}"
      @@score = @@score + 10 - @@hint
      puts "Your score is now #{@@score}"
    else
      puts "\nSorry, wrong answer.\nAnswer is: \n#{parsed_song.colorize(:yellow)} - #{song.artist.name.colorize(:yellow)} "
      puts "\nYour score is #{@@score}"
    end
  end

  def prompt_play_again
    puts "\nWanna play again? Type y or n:\n"
  end

  def repeat_or_exit
    while play_again = gets.chomp
      if play_again == "y"
        puts "Let's do it!"
        run
      elsif play_again == "n"
        puts "Your final score is: #{@@score}.\n\nBYE!"
        return true
      else
        puts "Please select either y or n"
      end
    end
  end

  def stars
    puts "********************************************************".red
  end

  def run
    exitted = false
    @@hint = 0
    greet
    input = gets_user_input
    categ = find_category(input)
    game_song = get_lyrics(categ)
    show_lyrics(game_song)
    input2 = prompt_answer_or_hint
    if input2 == 2
      show_all_lyrics(game_song)
      prompt_answer_or_hint_title(game_song)
    end
    prompt_answer
    answer = gets_user_input
    compare_answer(answer, game_song)
    prompt_play_again
    exitted = repeat_or_exit
    if exitted == true
      if HighScore.first.high_score < @@score
        HighScore.first.update(high_score: @@score)
        stars
        puts "YOU EARNED THE NEW HIGH SCORE : #{HighScore.first.high_score}"
        stars
      end
      exit
    end
  end


end
