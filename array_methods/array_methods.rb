# frozen_string_literal: true

# Returns a boolean value, whether the arrays have the same elements in the same order
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
  arr1_dup = arr1.dup
  arr2.each { |x| arr1_dup.slice!(arr1_dup.index(x)) if arr1_dup.include?(x) }
  arr1_dup
end

def insert_id!(arr, insertable)
  arr << insertable
  insertable
end

def insert_next_id!(arr, step = 1)
  sorted_array = arr.sort
  arr_length = arr.length
  i = 0
  insertable = 0

  while i < arr_length
    return insert_id!(arr, insertable) if insertable < sorted_array[i]

    insertable += step if insertable == sorted_array[i]
    i += 1 if insertable > sorted_array[i]
  end

  insert_id!(arr, insertable)
end
