class String
  def abbreviate
    self.split.map { |word| word[0] }.join
  end

  # calculator
  # case
  # valid password?

  def squash
    # Remove whitespace from a string
    self.gsub(/\s/, '')
  end
end
