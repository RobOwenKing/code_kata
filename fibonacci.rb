# Prints a given Fibonacci series (array) in the command line
def puts_fibonacci(series)
  puts series.join(', ')
end

# Prints the ratios between successive values of a given series
def puts_ratios(series)
  ratios = []
  (1...series.length).each do |term|
    ratios << series[term].fdiv(series[term - 1])
  end
  puts_fibonacci(ratios)
end

# Returns first num_terms terms of the Fibonacci series starting term1, term2
def fibonacci(term1, term2, num_terms)
  series = [term1, term2]
  series << series[-2] + series[-1] until series.length == num_terms
  series
end

def random_fibonacci(term1, term2, num_terms)
  series = [term1, term2]
  until series.length == num_terms do
    rand < 0.5 ? series << series[-2] + series[-1] : series << series[-2] - series[-1]
  end
  series
end

p random_fibonacci(0, 1, 10)
p random_fibonacci(0, 1, 10)
p random_fibonacci(0, 1, 10)
# puts_ratios(fibonacci(0, 1, 10))
