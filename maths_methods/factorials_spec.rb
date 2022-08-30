# frozen_string_literal: true

require 'rspec'
require_relative 'factorials'

RSpec.describe '#factorial' do
  it 'should return 1 when passed 0' do
    expect(factorial(0)).to be(1)
  end
  it 'should return nil when passed a negative number' do
    expect(factorial(-1)).to be(nil)
  end
  it 'should return the correct value for the factorial of positive integers' do
    expect(factorial(1)).to be(1)
    expect(factorial(2)).to be(2)
    expect(factorial(3)).to be(6)
    expect(factorial(5)).to be(120)
    expect(factorial(10)).to be(3628800)
  end
end
