class View
  attr_accessor :word

  def initialize
    @word = ''
  end

  def new_guess
    puts 'Guess a letter or word:'
    gets.chomp.upcase
  end

  def game_state
    puts @word.pattern.join(' ')
    puts "Wrong guesses: #{@word.incorrect_guesses.join(', ')}"
    puts @word.lives
  end

  def win_game
    puts "Congratulations!"
    puts "You win #{word.answer} with #{word.lives} lives to spare"
  end

  def game_over
    puts "Sorry, you lost. The answer was #{word.answer}"
  end
end
