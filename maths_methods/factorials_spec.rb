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

RSpec.describe '#multifactorial' do
  it 'should return 1 when passed start 0' do
    expect(multifactorial(0, 1).to be(1))
    expect(multifactorial(0, 2).to be(1))
  end
  it 'should be the same as #factorial when step = 1' do
    expect(multifactorial(1, 1)).to be(factorial(1))
    expect(multifactorial(2, 1)).to be(factorial(2))
    expect(multifactorial(4, 1)).to be(factorial(4))
    expect(multifactorial(9, 1)).to be(factorial(9))
  end
  it 'should be the same as #semifactorial when step = 2' do
    expect(multifactorial(1, 2)).to be(semifactorial(1))
    expect(multifactorial(2, 2)).to be(semifactorial(2))
    expect(multifactorial(4, 2)).to be(semifactorial(4))
    expect(multifactorial(9, 2)).to be(semifactorial(9))
  end
  it 'should work for higher values of step' do
    expect(multifactorial(6, 3)).to be(18)
    expect(multifactorial(6, 4)).to be(12)
    expect(multifactorial(6, 5)).to be(6)
    expect(multifactorial(7, 3)).to be(28)
    expect(multifactorial(7, 4)).to be(21)
    expect(multifactorial(7, 5)).to be(14)
    expect(multifactorial(10, 3)).to be(280)
    expect(multifactorial(10, 4)).to be(120)
    expect(multifactorial(10, 5)).to be(50)
  end
end
