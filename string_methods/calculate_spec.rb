require 'rspec'
require_relative 'calculate'

RSpec.describe String do
  describe '#calculate' do
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
      expect('4 + 2 + 1'.calculate).to eql(7)
    end
    it 'Can handle subtraction of multiple terms' do
      expect('4 - 2 - 1'.calculate).to eql(1)
    end
    it 'Can handle multiplication of multiple terms' do
      expect('4 * 2 * 1'.calculate).to eql(8)
    end
    it 'Can handle division of multiple terms' do
      expect('4 / 2 / 1'.calculate).to eql(2)
    end
  end
end
