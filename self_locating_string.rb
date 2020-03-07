def self_documenting_digits(number)
  number_string = number.to_s
  decimals = number_string.match(/\.\d+/)[0]
  documenting_array = []
  # puts decimals
  (1...decimals.length).each do |i|
    documenting_array << i if i.to_s == decimals.slice(i, i.to_s.length)
    # documenting_array << decimals.slice(i, i.to_s.length)
  end
  puts "Digits: #{documenting_array.join(', ')}"
  puts "Total: #{documenting_array.reduce(:+)}"
end

# self_documenting_digits(0.1)
# self_documenting_digits(".5")
# self_documenting_digits(3.1415926)
# self_documenting_digits(1.1259623587134875013486205132846018236053)
self_documenting_digits(Math::PI)
