require 'rspec'
require_relative 'parentheses'

RSpec.describe String do
  describe '#matching?' do
    it 'Returns true for a string with no parentheses' do
      expect('Returns true for a string...'.matching?).to eql(true)
    end
    it 'Handles the simplest valid case' do
      expect('(Yay!)'.matching?).to eql(true)
    end
    it 'Handles a more complex valid case' do
      expect('Still {[ yay ]?}'.matching?).to eql(true)
    end
    it 'Fails when the order is wrong' do
      expect('([)]'.matching?).to eql(false)
    end
    it 'Fails when more open than close' do
      expect('([{}]'.matching?).to eql(false)
    end
    it 'Fails when more close than open' do
      expect('[{}])'.matching?).to eql(false)
    end
  end
end
