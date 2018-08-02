class CommandLineInterface

  @@score = 0

  def greet
    puts "\nWelcome to Lyrics Trivia, get ready to test your music knowledge!\n\nLet's play.\n\nEnter a topic from the following options:\n- The Beatles\n- Justin Bieber\n- Beyonce/Destiny's Child\n- Today's Hits\n- 2000's Pop\n- 90's Pop\n\n"
  end

  def gets_user_input
    gets.chomp
  end

  def find_category(input)
    if Category.find_by(title: input) == nil
      puts "Sorry, that option is not available yet. Please try again from the options given."
      input = gets_user_input
      find_category(input)
    else
      Category.find_by(title: input)
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
    puts game_song.title
    puts "\nHere's some lyrics:"
    stars
    puts "#{game_song.lyrics[0..75].colorize(:blue)}\n"
    stars
  end

  def prompt_answer_or_hint
    puts "1) To guess the song now select 1.\n2) To get more lyrics select 2. Warning: this option is a 5 point penalty to your potential increase.\n"
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
    puts "1) To guess the song select 1. \n2) To get part of the song title select 2.\n"
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
    puts "\n#{song.lyrics.colorize(:blue)}\n"
    stars
  end

  def prompt_answer
    puts "\nPlease type your answer:\n"
  end

  def compare_answer(answer, song)
    parsed_song = song.title.split(' (')
    parsed_song = parsed_song.first
    if parsed_song.downcase == answer.downcase
      puts "\nCongrats! You got it right!\n"
      @@score = @@score + 10 - @@hint
      puts "Your score is now #{@@score}"
    else
      puts "\nSorry, wrong answer.\nAnswer is: \n#{parsed_song.colorize(:blue)}"
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
      exit
    end
  end


end
