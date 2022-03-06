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
