# inputs: target total, number of summands
# output: array of arrays
def killer_sudoku_decomp(total, no_of_parts)
  raise ArgumentError unless total.class == Integer
  return 'Total must be positive' unless total.positive?
  raise ArgumentError unless no_of_parts.class == Integer
  return 'Number of parts must be positive' unless no_of_parts.positive?

  options = []
  maximum = [total, 9].min
  (1..maximum).each do |i|
    options << [i]
  end

  while options[0].length < no_of_parts
    new_options = []
    options.each do |option|
      if option[-1] < maximum
        (option[-1]+1..maximum).each do |opt|
          option_clone = option.clone
          option_clone << opt
          new_options << option_clone
        end
      end
    end
    options = new_options
  end

  total_options = []
  options.each do |option|
    total_options << option if option.sum == total
  end
  total_options
end

p killer_sudoku_decomp(5, 2)
p killer_sudoku_decomp(15, 2)
p killer_sudoku_decomp(23, 4)
