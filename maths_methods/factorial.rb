def factorial(number)
  return nil if number.negative?
  return 1 if number.zero?

  (1..number).to_a.inject(:*)
end

# puts factorial(-1) # Should give nil
# puts factorial(0)  # Should give 1
# puts factorial(1)  # Should give 1
# puts factorial(2)  # Should give 2
# puts factorial(5)  # Should give 120
# puts factorial(10) # Should give 3628800

def choose(enn, kay)
  return nil if enn.negative? || kay.negative? || enn < kay

  factorial(enn) / (factorial(kay) * factorial(enn - kay))
end

# puts choose(1, 2) # Should give nil
# puts choose(2, 1) # Should give 2
# puts choose(4, 2) # Should give 6
# puts choose(9, 6) # Should give 84
