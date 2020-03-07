class Controller
  def initialize(view)
    @view = view
  end

  def guess_loop
    until @word.lives.zero? || @word.pattern == @word.answer_array
      @view.game_state
      guess = @view.new_guess
      puts @word.check_guess(guess) ? 'Good guess!' : "Sorry, that's not right"
      puts ''
    end
    @word.pattern == @word.answer_array ? @view.win_game : @view.game_over
  end

  def new_guess
    # Check non-empty, non-repeat
  end

  def new_game
    # Set difficulty

    @word = Word.new
    @view.word = @word
    puts "The answer is #{@word.answer.length} letters long. Good luck!"
    guess_loop
  end
end
