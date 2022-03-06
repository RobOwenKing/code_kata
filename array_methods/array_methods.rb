# frozen_string_literal: true

# Returns a boolean value, whether the arrays have same element in same order
def deep_equals?(arr1, arr2)
  return false if arr1.length != arr2.length

  arr1.each_with_index do |x, i|
    return false if x.instance_of?(Array) && !deep_equals?(x, arr2[i])
    return false if x != arr2[i]
  end

  true
end

# Returns a new array with elements of arr1 not in arr2
# Compare: [1, 2, 2] - [1, 2] #=> []
#          subtract([1, 2, 2], [1, 2]) #=> [2]
def subtract(arr1, arr2)
  arr1
end
