require 'rspec'
require_relative 'string_methods'

describe String do
  describe '#palindrome?' do
    it 'Correctly identifies a simple palindrome' do
      expect('radar'.palindrome?).to eql(true)
    end
    it 'Correctly identifies a palindrome, regardless of case' do
      expect('Radar'.palindrome?).to eql(true)
    end
    it 'Ignores punctuation and whitespace' do
      expect('A man, a plan, a cat, a canal – Panama!'.palindrome?).to eql(true)
    end
    it 'Can handle numbers' do
      expect('02/02/2020'.palindrome?).to eql(true)
    end
    it "Doesn't give false positives with words" do
      expect('Radad'.palindrome?).to eql(false)
    end
    it "Doesn't give false positives with numbers" do
      expect('3.14159'.palindrome?).to eql(false)
    end
  end
end
