# First draft of main logic before applying MVC model

def ask_for_guess
  puts 'Guess a letter'
  gets.chomp.upcase
end

def hangman_round(word)
  target_word = word.upcase.split('')
  p target_word

  correct_guesses = []
  target_word.length.times { correct_guesses << '_' }
  p correct_guesses

  wrong_guesses = []
  10.times { wrong_guesses << "<3" }
  p wrong_guesses

  new_letter = ask_for_guess
  p new_letter

  if target_word.include?(new_letter)
    matches = []
    target_word.each_with_index do |char, index|
      matches << index if char == new_letter
    end
    matches.each { |index| correct_guesses[index] = new_letter }
  end

  p correct_guesses
end

hangman_round("example")
