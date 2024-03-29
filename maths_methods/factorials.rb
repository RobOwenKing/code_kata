# CONTENTS
# - #factorial
# - #semifactorial
# - #multifactorial
# - #primorial

# Reference:
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

# Recursively calculate the semifactorial of a number
# Called from #semifactorial so we can skip checking validity of argument
def iterate_semifactorial(number)
  return 1 if number <= 1

  number * iterate_semifactorial(number - 2)
end

# Wikipedia: "In mathematics, the double factorial or semifactorial
#   of a number n (denoted by n!!) is the product of all the integers
#   from 1 up to n that have the same parity (odd or even) as n."
def semifactorial(number)
  return nil if number.negative? || number.to_i != number

  iterate_semifactorial(number)
end

# Recursively calculate the multifactorial of a number
# Called from #multifactorial so we can skip checking validity of argument
def iterate_multifactorial(number, step)
  return 1 if number <= 1

  number * iterate_multifactorial(number - step, step)
end

def multifactorial(number, step)
  return nil if number.negative? || number.to_i != number

  iterate_multifactorial(number, step)
end

IS_PRIME = [false, false, true]

def primes_less_than(number)
  return if number < IS_PRIME.length

  l = IS_PRIME.length
  (number - l + 1).times { IS_PRIME << true }
  (2..Math.sqrt(number)).each do |i|
    next unless IS_PRIME[i]

    (i * [i, l / i].max..number).step(i) do |j|
      IS_PRIME[j] = false
    end
  end
end

def primorial(number)
  primes_less_than(number) # Make sure IS_PRIME has enough values

  answer = 1
  (0..number).each { |i| answer *= i if IS_PRIME[i] }
  answer
end

def hyperfactorial(number)
  return 1 if number.zero?

  (1..number).to_a.map { |x| x**x }.inject(:*)
end
