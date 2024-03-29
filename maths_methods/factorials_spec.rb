require 'rspec'
require_relative 'factorials'

RSpec.describe '#factorial' do
  it 'should return 1 when passed 0' do
    expect(factorial(0)).to eq(1)
  end
  it 'should return nil when passed a negative number' do
    expect(factorial(-1)).to eq(nil)
  end
  it 'should return nil when passed a float' do
    expect(factorial(2.5)).to eq(nil)
  end
  it 'should return the correct value for the factorial of positive integers' do
    expect(factorial(1)).to eq(1)
    expect(factorial(2)).to eq(2)
    expect(factorial(3)).to eq(6)
    expect(factorial(5)).to eq(120)
    expect(factorial(10)).to eq(3_628_800)
  end
end

RSpec.describe '#semifactorial' do
  it 'should return 1 when passed 0' do
    expect(semifactorial(0)).to eq(1)
  end
  it 'should return nil when passed a negative number' do
    expect(semifactorial(-1)).to eq(nil)
  end
  it 'should return nil when passed a float' do
    expect(semifactorial(2.5)).to eq(nil)
  end
  it 'should return the correct value for the semifactorial of positive integers' do
    expect(semifactorial(1)).to eq(1)
    expect(semifactorial(2)).to eq(2)
    expect(semifactorial(3)).to eq(3)
    expect(semifactorial(5)).to eq(15)
    expect(semifactorial(10)).to eq(3840)
  end
  it 'should match up with #factorial' do
    expect(semifactorial(9) * semifactorial(10)).to eq(factorial(10))
  end
end

RSpec.describe '#multifactorial' do
  it 'should return 1 when passed number 0' do
    expect(multifactorial(0, 1)).to eq(1)
    expect(multifactorial(0, 2)).to eq(1)
  end
  it 'should be the same as #factorial when step = 1' do
    expect(multifactorial(1, 1)).to eq(factorial(1))
    expect(multifactorial(2, 1)).to eq(factorial(2))
    expect(multifactorial(4, 1)).to eq(factorial(4))
    expect(multifactorial(9, 1)).to eq(factorial(9))
  end
  it 'should be the same as #semifactorial when step = 2' do
    expect(multifactorial(1, 2)).to eq(semifactorial(1))
    expect(multifactorial(2, 2)).to eq(semifactorial(2))
    expect(multifactorial(4, 2)).to eq(semifactorial(4))
    expect(multifactorial(9, 2)).to eq(semifactorial(9))
  end
  it 'should work for higher values of step' do
    expect(multifactorial(6, 3)).to eq(18)
    expect(multifactorial(6, 4)).to eq(12)
    expect(multifactorial(6, 5)).to eq(6)
    expect(multifactorial(7, 3)).to eq(28)
    expect(multifactorial(7, 4)).to eq(21)
    expect(multifactorial(7, 5)).to eq(14)
    expect(multifactorial(10, 3)).to eq(280)
    expect(multifactorial(10, 4)).to eq(120)
    expect(multifactorial(10, 5)).to eq(50)
  end
end

RSpec.describe '#primorial' do
  it 'should return 1 when passed 0 or 1' do
    expect(primorial(0)).to eq(1)
    expect(primorial(0)).to eq(1)
  end
  it 'should return the correct value for larger numbers' do
    expect(primorial(2)).to eq(2)
    expect(primorial(3)).to eq(6)
    expect(primorial(4)).to eq(6)
    expect(primorial(5)).to eq(30)
    expect(primorial(6)).to eq(30)
    expect(primorial(7)).to eq(210)
    expect(primorial(10)).to eq(210)
  end
end

RSpec.describe '#hyperfactorial' do
  it 'should return 1 when passed 0' do
    expect(hyperfactorial(0)).to eq(1)
  end
  it 'should return 1 when passed 1' do
    expect(hyperfactorial(1)).to eq(1)
  end
  it 'should return the correct values for larger arguments' do
    expect(hyperfactorial(2)).to eq(4)
    expect(hyperfactorial(3)).to eq(108)
    expect(hyperfactorial(4)).to eq(27_648)
    expect(hyperfactorial(5)).to eq(86_400_000)
  end
end
