def guesses_generator_3(max_length)
  results = ['']
  results.each do |result|
    if result.length < max_length
      ('a'..'z').each do |letter|
        results << result + letter
      end
    end
  end
  results.delete_at(0)
  results
end

p guesses_generator_3(2)

def guesses_generator_2(max_length)
  results = []
  working_array = ['']
  (1..max_length).each do
    iteration_array = []
    (0...working_array.length).each do |index|
      ('a'..'z').each do |letter|
        iteration_array << working_array[index] + letter
      end
    end
    iteration_array.each { |element| results << element }
    working_array = iteration_array
  end
  results
end

# p guesses_generator_2(3)

def create_string(number, length, alphabet)
  current_option = ''
  (1..length).to_a.reverse.each do |position|
    counter = 0
    units = alphabet.length**(position - 1)
    counter += 1 while counter * units < number
    counter -= 1
    current_option += alphabet[counter]
    number -= counter * units
  end
  current_option
end

def guesses_generator(max_length)
  alphabet = ('a'..'z').to_a.join
  options = []

  (1..max_length).each do |length|
    max_number = alphabet.length**length
    (0...max_number).each do |number|
      options << create_string(number, length, alphabet)
    end
  end

  options
end

# p guesses_generator(2)

# Original version

# def guesses_generator(max_length)
#   alphabet = ('a'..'z').to_a.join
#   options = []

#   (1..max_length).each do |length|
#     max_number = alphabet.length**length
#     # options << max_number
#     (0...max_number).each do |number|
#       # options << number
#       # current_option = ''
#       # (1..length).to_a.reverse.each do |position|
#       #   counter = 0
#       #   units = alphabet.length ** (position - 1)
#       #   counter += 1 while counter * units < number
#       #   counter -= 1
#       #   current_option += alphabet[counter]
#       #   number -= counter * units
#       # end
#       options << number_to_string(number, length, alphabet)
#     end
#   end

#   options
# end
