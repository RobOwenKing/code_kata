# https://www.youtube.com/watch?v=7eboFOkRHr4

def factorial(number)
  return nil if number.negative? || number.to_i != number
  return 1 if number.zero?

  (1..number).to_a.inject(:*)
end

def choose(enn, kay)
  return nil if enn.negative? || kay.negative? || enn < kay

  factorial(enn) / (factorial(kay) * factorial(enn - kay))
end

# puts choose(1, 2) # Should give nil
# puts choose(2, 1) # Should give 2
# puts choose(4, 2) # Should give 6
# puts choose(9, 6) # Should give 84

# Wikipedia: "In mathematics, the double factorial or semifactorial
#   of a number n (denoted by n!!) is the product of all the integers
#   from 1 up to n that have the same parity (odd or even) as n."
def semifactorial(number)
  return nil if number.negative? || number.to_i != number
  return 1 if number.zero?

  list = number.odd? ? (1..number).select { |n| n.odd? } : (1..number).select { |n| n.even? }
  list.inject(:*)
end

# Old semifactorial
  # all = (1..number).to_a
  # parity = all.select { |current| current.odd? == number.odd? }
  # parity.inject(:*)
