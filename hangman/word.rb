require 'csv'

class Word
  attr_reader :answer, :answer_array, :pattern, :incorrect_guesses
  attr_accessor :lives

  def initialize
    @answer = select_target_word
    @answer_array = @answer.upcase.split('')
    @pattern = create_pattern(answer_array)
    @incorrect_guesses = []
    @lives = 10
  end

  def select_target_word
    line = rand(45_425)
    word = CSV.readlines('hangman/wordlist.txt')[line]
    word[0]
  end

  def create_pattern(answer_array)
    pattern = []
    answer_array.length.times { pattern << '_' }
    pattern
  end

  def check_guess_word(guess)
    if @answer.upcase == guess
      @pattern = answer_array
      true
    else
      @incorrect_guesses << guess
      @lives -= 1
      false
    end
  end

  def check_guess_letter(guess)
    if @answer_array.include?(guess)
      matches = []
      @answer_array.each_with_index do |char, index|
        matches << index if char == guess
      end
      matches.each { |index| pattern[index] = guess }
      true
    else
      @incorrect_guesses << guess
      @lives -= 1
      false
    end
  end

  def check_guess(guess)
    guess.length == 1 ? check_guess_letter(guess) : check_guess_word(guess)
  end
end
