require 'rspec'
require_relative 'calculate'

RSpec.describe String do
  describe '#calculate' do
    it 'Returns a single digit' do
      expect('2'.calculate).to eql(2)
    end
    it 'Returns a single number' do
      expect('22'.calculate).to eql(22)
    end
    it 'Can handle addition of two terms' do
      expect('2 + 2'.calculate).to eql(4)
    end
    it 'Can handle subtraction of two terms' do
      expect('2 - 2'.calculate).to eql(0)
    end
    it 'Can handle multiplication of two terms' do
      expect('2 * 2'.calculate).to eql(4)
    end
    it 'Can handle division of two terms' do
      expect('2 / 2'.calculate).to eql(1)
    end
    it 'Can handle addition of multiple terms' do
      expect('12 + 3 + 4'.calculate).to eql(19)
    end
    it 'Can handle subtraction of multiple terms' do
      expect('12 - 3 - 4'.calculate).to eql(5)
    end
    it 'Can handle multiplication of multiple terms' do
      expect('12 * 3 * 4'.calculate).to eql(144)
    end
    it 'Can handle division of multiple terms' do
      expect('12 / 3 / 4'.calculate).to eql(1)
    end
    it 'Accepts shorthand to add list of numbers' do
      expect('+ 12 3 4'.calculate).to eql(19)
    end
    it 'Accepts shorthand to subtract list of numbers' do
      expect('- 12 3 4'.calculate).to eql(5)
    end
    it 'Accepts shorthand to multiply list of numbers' do
      expect('* 12 3 4'.calculate).to eql(144)
    end
    it 'Accepts shorthand to divide list of numbers' do
      expect('/ 12 3 4'.calculate).to eql(1)
    end
    it 'Can handle negative numbers in lists (addition)' do
      expect('+ 12 3 -4'.calculate).to eql(11)
    end
    it 'Can handle negative numbers in lists (subtraction)' do
      expect('- -12 3 4'.calculate).to eql(-19)
    end
    it 'Can handle negative numbers in lists (multiplication)' do
      expect('* 12 -3 4'.calculate).to eql(-144)
    end
  end
end
