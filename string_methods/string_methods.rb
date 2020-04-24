require_relative 'properties'

class String
  def abbreviate
    self.split.map { |word| word.roman_numeral? ? word : word[0] }.join
  end

  # calculator
  # case

  def squash
    # Remove whitespace from a string
    self.gsub(/\s/, '')
  end
end
