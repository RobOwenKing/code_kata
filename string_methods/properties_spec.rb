require 'rspec'
require_relative 'properties'

RSpec.describe String do
  # describe '#palindrome?' do
  #   it 'Correctly identifies a simple palindrome' do
  #     expect('radar').to be_palindrome
  #   end
  #   it 'Correctly identifies a palindrome, regardless of case' do
  #     expect('Radar').to be_palindrome
  #   end
  #   it 'Ignores punctuation and whitespace' do
  #     expect('A man, a plan, a cat, a canal – Panama!').to be_palindrome
  #   end
  #   it 'Can handle numbers' do
  #     expect('02/02/2020').to be_palindrome
  #   end
  #   it "Doesn't give false positives with words" do
  #     expect('Radad').to_not be_palindrome
  #   end
  #   it "Doesn't give false positives with numbers" do
  #     expect('3.14159').to_not be_palindrome
  #   end
  # end

  # describe '#pangram?' do
  #   subject { ('a'..'z').to_a.join }
  #   it 'Correctly identifies the alphabet as a pangram' do
  #     expect(subject).to be_pangram
  #   end
  #   it 'Correctly identifies a more complex pangram' do
  #     expect('The quick brown fox jumps over the lazy dog.').to be_pangram
  #   end
  #   it "Doesn't give a false positive for a near-pangram" do
  #     expect(subject.slice(0..-2)).to_not be_pangram
  #   end
  # end

  # describe '#valid_password?' do
  #   it 'Correctly identifies a valid password' do
  #     expect('V4lidP4ssword!').to be_valid_password
  #   end
  #   it 'Must be more than 7 characters long' do
  #     expect('passwor').to_not be_valid_password
  #   end
  #   it 'Must include at least one lowercase letter' do
  #     expect('PASSWORD1!').to_not be_valid_password
  #   end
  #   it 'Must include at least one uppercase letter' do
  #     expect('password1!').to_not be_valid_password
  #   end
  #   it 'Must include at least one number' do
  #     expect('Password!').to_not be_valid_password
  #   end
  #   it 'Must include at least one punctuation mark' do
  #     expect('Password1').to_not be_valid_password
  #   end
  #   it 'Can cope with _' do
  #     expect('Pass_word1').to be_valid_password
  #   end
  #   it 'Can cope with .' do
  #     expect('Pass.word1').to be_valid_password
  #   end
  #   it 'Should not include any whitespace' do
  #     expect('Pass word1!').to_not be_valid_password
  #   end
  # end

  describe '#roman_numeral?' do
    it 'Identifies a single valid digit' do
      expect('D').to be_roman_numeral
    end
    it 'Identifies valid repeated digit' do
      expect('III').to be_roman_numeral
    end
    it "Doesn't accept too many repetitions of a digit (I)" do
      expect('IIII').to_not be_roman_numeral
    end
    it "Doesn't accept too many repetitions of a digit (V)" do
      expect('VV').to_not be_roman_numeral
    end
    it 'Accepts a simple valid additive numeral' do
      expect('VI').to be_roman_numeral
    end
    it 'Accepts a simple valid subtractive numeral' do
      expect('IV').to be_roman_numeral
    end
    it 'Identifies a simple non-consecutive numeral' do
      expect('MMXX').to be_roman_numeral
    end
    it 'Identifies a complex numeral' do
      expect('XLII').to be_roman_numeral
    end
    it "Doesn't accept extra letters" do
      expect('XLIIA').to_not be_roman_numeral
    end
    it "Doesn't accept letters in an invalid order" do
      expect('IVXC').to_not be_roman_numeral
    end
    it "Doesn't accept invalid combinations of valid subsets" do
      expect('IXVII').to_not be_roman_numeral
    end
    it "Doesn't accept the empty string" do
      expect('').to_not be_roman_numeral
    end
  end

  # describe '#count_vowels' do
  #   it 'Correctly counts vowels regardless of case' do
  #     expect('AaIiUuEeO'.count_vowels).to eql(9)
  #   end
  #   it 'Ignores consonants' do
  #     expect('Counting vowels'.count_vowels).to eql(5)
  #   end
  #   it 'Can cope with a lack of vowels' do
  #     expect('rhythm'.count_vowels).to eql(0)
  #   end
  # end

  # describe '#count_consonants' do
  #   it 'Correctly counts consonants regardless of case' do
  #     expect('BbZzTtHjFVG'.count_consonants).to eql(11)
  #   end
  #   it 'Ignores vowels' do
  #     expect('Counting consonants'.count_consonants).to eql(12)
  #   end
  #   it 'Can cope with a lack of consonants' do
  #     expect('aeiou'.count_consonants).to eql(0)
  #   end
  # end
end
