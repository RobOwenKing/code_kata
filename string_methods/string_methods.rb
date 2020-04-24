class String
  def palindrome?
    # We ignore case, whitespace and punctuation for comparison purposes
    relevant_chars = self.downcase.gsub(/[^A-Za-z0-9]/, '')
    relevant_chars == relevant_chars.reverse
  end

  def pangram?
    a_to_z = ('a'..'z').to_a
    all_there = true
    a_to_z.each { |letter| all_there = false unless self.include? letter }
    all_there
  end

  def count_vowels
    self.count 'aeiouAEIOU'
  end

  def count_consonants
    # self.count 'b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z'
    self.count 'A-Za-z', '^aeiouAEIOU'
  end

  # caesar shift
  def caesar(offset = 1)
    a_to_z = ('a'..'z').to_a
    offset_alphabet = a_to_z.slice!((offset % 26)...a_to_z.length) + a_to_z
    alphabet_string = offset_alphabet.join
    self.tr('A-Za-z', alphabet_string.upcase + alphabet_string)
  end

  # calculator
  # case
  # abbreviate
  # valid password?

  def squash
    # Remove whitespace from a string
    self.gsub(/\s/, '')
  end
end
