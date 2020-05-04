require 'prime'

# Third attempt (much faster algorithm)
def factorise(number)
  factors = []
  candidate = 2
  while number >= candidate
    if Prime.prime?(candidate)
      while (number % candidate).zero?
        factors << candidate
        number /= candidate
      end
    end
    candidate += 1
  end
  factors
end

def prime_factors(number)
  number = number.to_i if number.is_a?(String)

  return 'Error: Input too small' if number < 2
  return "#{number} is prime" if Prime.prime?(number)

  "Prime factors of #{number}: #{factorise(number)}"
end

puts prime_factors(0)
puts prime_factors(2)
puts prime_factors(7)
puts prime_factors(14)
puts prime_factors(60)
puts prime_factors(1001)
puts prime_factors(1_254_821)
puts prime_factors(1_254_823)
puts prime_factors(1_254_825)

# Second attempt (simplified from first)

# def factorise(number)
#   factors = []
#   (2..number / 2).to_a.each do |candidate|
#     next unless Prime.prime?(candidate)

#     while (number % candidate).zero?
#       factors << candidate
#       number /= candidate
#     end
#   end
#   factors
# end


# First attempt

# def factorise(number)
#   factors = []
#   (2..number / 2).to_a.each do |candidate|
#     next unless Prime.prime?(candidate)

#     powers = candidate
#     while (number % powers).zero?
#       factors << candidate
#       powers *= candidate
#     end
#   end
#   factors
# end
