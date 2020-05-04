def coprime?(a, b)
  a.gcd(b) == 1
end

def totient(n)
  (0..n).to_a.count { |num| coprime?(n, num) }
end

# puts coprime?(3, 6)
# puts coprime?(4, 6)
# puts coprime?(5, 6)

puts totient(9)  # Should be 6
puts totient(12) # Should be 4
puts totient(13) # Should be 12
# Speed tests
puts totient(1_001)   # Should be 720
puts totient(10_001)  # Should be 9792
puts totient(100_001) # Should be 90900
