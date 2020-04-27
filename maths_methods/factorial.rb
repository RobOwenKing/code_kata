def factorial(number)
  return 'nil' if number.negative?
  return 1 if number.zero?

  (1..number).to_a.inject(:*)
end

puts factorial(-1)
puts factorial(0)
puts factorial(1)
puts factorial(2)
puts factorial(3)
puts factorial(4)
puts factorial(5)
