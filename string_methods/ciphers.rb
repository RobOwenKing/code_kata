class String
  def caesar(offset = 1)
    a_to_z = ('a'..'z').to_a
    offset_alphabet = a_to_z.slice!((offset % 26)...a_to_z.length) + a_to_z
    alphabet_string = offset_alphabet.join
    self.tr('A-Za-z', alphabet_string.upcase + alphabet_string)
  end
end
