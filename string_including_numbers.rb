# Select those strings which match the regex expression for including a digit
def with_numbers_regex(array_of_strings)
  array_of_strings.select { |string| string.match?(/\d/) }
end

# Method that iterates over a string's characters to see if any are digits
def includes_number?(string)
  digits = ('0'..'9').to_a
  string.each_char do |char|
    return true if digits.include?(char)
  end
  false
end

# Select those strings which include a digit using the method just defined
def with_numbers_no_regex(array_of_strings)
  array_of_strings.select { |string| includes_number?(string) }
end

star_wars_heroes = ['Leia', 'R2D2', 'C3PO', 'Luke', 'Darth Vader', 'BB-8']

puts 'Regex version:'
p with_numbers_regex(star_wars_heroes)
puts 'Non-regex version:'
p with_numbers_no_regex(star_wars_heroes)


# Testing how much quicker it would be to store the digits array in a variable
# As opposed to creating it afresh every time

# def timer
#   start_time = Time.now
#   yield
#   end_time = Time.now
#   puts "That took #{end_time - start_time}"
# end

# timer do
#   puts 'Variable version:'
#   digits = ('0'..'9').to_a
#   10000.times do
#     digits.include?('a')
#   end
# end

# timer do
#   puts 'Range version:'
#   10000.times do
#     ('0'..'9').to_a.include?('a')
#   end
# end
