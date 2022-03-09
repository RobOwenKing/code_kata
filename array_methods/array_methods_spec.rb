# frozen_string_literal: true

require 'rspec'
require_relative 'array_methods'

RSpec.describe '#deep_equals?' do
  it 'should return true when true' do
    expect(deep_equals?([1, 2, 3], [1, 2, 3])).to be true
  end
  it 'should return true when nested arrays match too' do
    expect(deep_equals?([1, 2, [1, 2]], [1, 2, [1, 2]])).to be true
  end
  it 'should return false when false' do
    expect(deep_equals?([1, 2, 3], [4, 5, 6])).to be false
  end
  it 'should return false when nested arrays do not match' do
    expect(deep_equals?([1, 2, [1, 2]], [1, 2, [1, 3]])).to be false
  end
  it 'should return false when same elements, not in the same order' do
    expect(deep_equals?([1, 2, 3], [1, 3, 2])).to be false
  end
  it 'should return false when arr1 a subset of arr2' do
    expect(deep_equals?([1, 2], [1, 2, 3])).to be false
  end
  it 'should return false when arr2 a subset of arr1' do
    expect(deep_equals?([1, 2, 3], [1, 2])).to be false
  end
end

RSpec.describe '#subtract' do
  it 'should delete elements in arr2' do
    ans = subtract([1, 2, 3], [1, 3])
    expect(ans.include?(1)).to be false
    expect(ans.include?(3)).to be false
  end
  it 'should leave elements not in arr 2' do
    ans = subtract([1, 2, 3], [1, 3])
    expect(ans.include?(2)).to be true
  end
  it 'should work when elements in different orders in arr1 and arr2' do
    ans = subtract([1, 2, 3], [3, 1])
    expect(deep_equals?(ans, [2])).to be true
  end
  it 'should delete repeats correct number of times' do
    ans = subtract([1, 2, 3, 2, 2], [1, 2, 2, 3])
    expect(ans.include?(2)).to be true
  end
  it 'should not collapse when arr2 includes digits not in arr1' do
    ans = subtract([1, 2, 3], [2, 4])
    expect(deep_equals?(ans, [1, 3])).to be true
  end
end

RSpec.describe '#insert_next_id!' do
  it 'should make the array 1 element longer' do
    arr = [0, 1, 2, 4, 5]
    original_length = arr.length
    insert_next_id!(arr)
    expect(arr.length).to be(original_length + 1)
  end
  it 'should insert the next integer not in the array and return that digit' do
    arr = [0, 1, 2, 3, 4]
    expect(arr.include?(5)).to be false
    ret = insert_next_id!(arr)
    expect(arr.include?(5)).to be true
    expect(ret).to be(5)
  end
  it 'should not alter any elements of the original array' do
    arr = [4, 3, 2, 1, 0]
    insert_next_id!(arr)
    (0..4).each { |i| expect(arr[i]).to be(4 - i) }
  end
  it 'should work if there are gaps in the digits in the array' do
    arr = [0, 1, 2, 4, 5]
    expect(arr.include?(3)).to be false
    insert_next_id!(arr)
    expect(arr.include?(3)).to be true
  end
  it 'should work if the digits are not in sorted order' do
    arr = [2, 4, 1, 5, 0]
    expect(arr.include?(3)).to be false
    insert_next_id!(arr)
    expect(arr.include?(3)).to be true
  end
  it 'should start counting from 0 by default' do
    arr = [1, 2, 3, 4, 5]
    expect(arr.include?(0)).to be false
    insert_next_id!(arr)
    expect(arr.include?(0)).to be true
  end
  it 'should allow users to set a different step size' do
    arr = [0, 0.5, 1, 2]
    insert_next_id!(arr, 0.5)
    expect(arr.include?(1.5)).to be true
  end
  it 'should allow users to set a different starting value' do
    arr = [1, 2, 3]
    insert_next_id!(arr, 1, 1)
    expect(arr.include?(4)).to be true
  end
  it 'should allow users to set an end value, returning nil if no option for insert' do
    arr = [0, 1, 2, 3]
    original_length = arr.length
    expect(insert_next_id!(arr, 1, 0, 3)).to be nil
    expect(arr.length).to be(original_length)
  end
end
