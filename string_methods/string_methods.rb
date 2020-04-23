class String
  def palindrome?
    # We ignore case, whitespace and punctuation for comparison purposes
    relevant_chars = self.downcase.gsub(/[^A-Za-z0-9]/, '')
    relevant_chars == relevant_chars.reverse
  end

  def count_vowels
    self.count 'aeiouAEIOU'
  end

  def count_consonants
    # self.count 'b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z'
    self.count 'A-Za-z', '^aeiouAEIOU'
  end

  # caesar shift
  # calculator
  # case

  def squash
    # Remove whitespace from a string
    self.gsub(/\s/, '')
  end
end
