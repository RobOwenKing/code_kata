def coprime?(a, b)
  a.gcd(b) == 1
end

def totient(n)
  (0..n).to_a.count { |num| coprime?(n,num) }
end

# puts coprime?(3, 6)
# puts coprime?(4, 6)
# puts coprime?(5, 6)

puts totient(9)  # Should be 6
puts totient(12) # Should be 4
puts totient(13) # Should be 12
