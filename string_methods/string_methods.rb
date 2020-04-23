class String
  # Checks if a string is a palindrome, regardless of case, whitespace and punctuation
  def palindrome?
    relevant_chars = self.downcase.gsub(/[^A-Za-z0-9]/, '')
    relevant_chars == relevant_chars.reverse
  end

  # count vowels, consonants
  # caesar shift
  # calculator
  # case

  # Remove whitespace from a string
  def squash
    self.gsub(/\s/, '')
  end
end
