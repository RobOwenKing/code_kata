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
  it 'should return nil when passed a float' do
    expect(factorial(2.5)).to be(nil)
  end
  it 'should return the correct value for the factorial of positive integers' do
    expect(factorial(1)).to be(1)
    expect(factorial(2)).to be(2)
    expect(factorial(3)).to be(6)
    expect(factorial(5)).to be(120)
    expect(factorial(10)).to be(3628800)
  end
end

RSpec.describe '#semifactorial' do
  it 'should return 1 when passed 0' do
    expect(semifactorial(0)).to be(1)
  end
  it 'should return nil when passed a negative number' do
    expect(semifactorial(-1)).to be(nil)
  end
  it 'should return nil when passed a float' do
    expect(semifactorial(2.5)).to be(nil)
  end
  it 'should return the correct value for the semifactorial of positive integers' do
    expect(semifactorial(1)).to be(1)
    expect(semifactorial(2)).to be(2)
    expect(semifactorial(3)).to be(3)
    expect(semifactorial(5)).to be(15)
    expect(semifactorial(10)).to be(3840)
  end
  it 'should match up with #factorial' do
    expect(semifactorial(9)*semifactorial(10)).to be(factorial(10))
  end
end
