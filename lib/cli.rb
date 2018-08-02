class CommandLineInterface

  @@score = 0
  @@hint = 0

  def greet
    puts 'Welcome to Lyrics Trivia, get ready to test your music knowledge!'
    puts "Let's play."
    puts "Enter a topic from the following options:"
    puts "The Beatles\nJustin Beiber\nBeyonce/Destiny's Child\nToday's Hits\n2000's Pop\n90's Pop\n"
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

  def get_lyrics(categ)
    selection = Song.select do |song|
      categ.id == song.category_id
    end
    puts selection.sample
    selection.sample
  end

  def show_lyrics(game_song)
    puts "\nHere's some lyrics: \n#{game_song.lyrics[0..50]}\n\n"
  end

  def prompt_answer_or_hint
    puts "To guess the song select 1, or to get more lyrics select 2.\n"
    while user_input = gets.chomp
     case user_input
     when "1"
       return 1
     when "2"
       return 2
     else
       puts "Please select either 1 or 2"
       # prompt_answer_or_hint
     end
    end
  end

  def show_all_lyrics(song)
    @@hint = 5
    puts "\n#{song.lyrics}\n"
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
      puts "Sorry, wrong answer.\n Answer is: \n#{parsed_song}"
      puts "Your score is now #{@@score}"
    end
  end

  def prompt_play_again
    puts "\n Wanna play again? Type y or n:\n"
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
        # repeat_or_exit
      end
    end
  end

  def run
    exitted = false
    greet
    input = gets_user_input
    categ = find_category(input)
    game_song = get_lyrics(categ)
    show_lyrics(game_song)
    input2 = prompt_answer_or_hint
    if input2 == 2
      show_all_lyrics(game_song)
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
