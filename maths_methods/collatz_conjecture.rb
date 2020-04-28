def collatz(number)
  collatz_sequence = []
  collatz_sequence << number.to_s
  until number == 1
    number.even? ? number /= 2 : number = (3 * number) + 1
    collatz_sequence << number
  end
  # collatz_sequence.join(' -> ')
  collatz_sequence.length
end

# Finds the maximum value on the path from any input "number" to 0
def collatz_peak(number)
  peak = number
  until number == 1
    number.even? ? number /= 2 : number = (3 * number) + 1
    peak = number > peak ? number : peak
  end
  # collatz_sequence.join(' -> ')
  peak
end

# puts collatz(4)
# puts collatz(5)
# puts collatz(7)
# puts collatz(10)
# puts collatz(100)
# puts collatz(1000)
# puts collatz(10000)
# puts collatz(100_000)

puts collatz_peak(4)
puts collatz_peak(5)
puts collatz_peak(7)
puts collatz_peak(10)
puts collatz_peak(100)
puts collatz_peak(1000)
puts collatz_peak(10000)
puts collatz_peak(100_000)
