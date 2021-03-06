class String
  def palindrome?
    # We ignore case, whitespace and punctuation for comparison purposes
    relevant_chars = self.downcase.gsub(/[^A-Za-z0-9]/, '')
    relevant_chars == relevant_chars.reverse
  end

  def pangram?
    ('a'..'z').to_a.all? { |letter| self.include? letter }

    # a_to_z = ('a'..'z').to_a
    # testee = string.downcase
    # a_to_z.each { |letter| return false unless testee.include? letter }
    # true
  end

  def valid_password?
    return false if self.length < 8
    return false unless self.index(/\s/).nil?
    return false unless ('a'..'z').to_a.any? { |x| self.include? x }
    return false unless ('A'..'Z').to_a.any? { |x| self.include? x }
    return false unless ('0'..'9').to_a.any? { |x| self.include? x }
    return false if self.index(/[_\W]/).nil?

    true
  end

  def roman_numeral?
    return false if self.length.zero?

    self.match?(/^M{0,3}(C[MD]|D?C{0,3})?(X[CL]|L?X{0,3})?(I[XV]|V?I{0,3})?$/)
  end

  def count_vowels
    self.count 'aeiouAEIOU'
  end

  def count_consonants
    # self.count 'b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z'
    self.count 'A-Za-z', '^aeiouAEIOU'
  end
end
