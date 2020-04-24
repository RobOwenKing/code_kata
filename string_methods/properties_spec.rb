require 'rspec'
require_relative 'properties'

RSpec.describe String do
  describe '#palindrome?' do
    it 'Correctly identifies a simple palindrome' do
      expect('radar').to be_palindrome
    end
    it 'Correctly identifies a palindrome, regardless of case' do
      expect('Radar').to be_palindrome
    end
    it 'Ignores punctuation and whitespace' do
      expect('A man, a plan, a cat, a canal – Panama!').to be_palindrome
    end
    it 'Can handle numbers' do
      expect('02/02/2020').to be_palindrome
    end
    it "Doesn't give false positives with words" do
      expect('Radad').to_not be_palindrome
    end
    it "Doesn't give false positives with numbers" do
      expect('3.14159').to_not be_palindrome
    end
  end

  describe '#pangram?' do
    subject { ('a'..'z').to_a.join }
    it 'Correctly identifies the alphabet as a pangram' do
      expect(subject).to be_pangram
    end
    it 'Correctly identifies a more complex pangram' do
      expect('The quick brown fox jumps over the lazy dog.').to be_pangram
    end
    it "Doesn't give a false positive for a near-pangram" do
      expect(subject.slice(0..-2)).to_not be_pangram
    end
  end

  describe '#count_vowels' do
    it 'Correctly counts vowels regardless of case' do
      expect('AaIiUuEeO'.count_vowels).to eql(9)
    end
    it 'Ignores consonants' do
      expect('Counting vowels'.count_vowels).to eql(5)
    end
    it 'Can cope with a lack of vowels' do
      expect('rhythm'.count_vowels).to eql(0)
    end
  end

  describe '#count_consonants' do
    it 'Correctly counts consonants regardless of case' do
      expect('BbZzTtHjFVG'.count_consonants).to eql(11)
    end
    it 'Ignores vowels' do
      expect('Counting consonants'.count_consonants).to eql(12)
    end
    it 'Can cope with a lack of consonants' do
      expect('aeiou'.count_consonants).to eql(0)
    end
  end
end
