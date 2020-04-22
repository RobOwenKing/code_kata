class String
  def palindrome?
    self == self.reverse
  end

  # count vowels, consonants
  # caesar shift
  # calculator

  # remove whitespace
  def squash
    self.gsub(/\s/, '')
  end
end

puts 'Radar'.reverse

puts 'radar'.palindrome?
puts 'radad'.palindrome?
puts 'Radar'.palindrome?

puts 'Testing testing one two three'.squash

puts 'Radar'.reverse
