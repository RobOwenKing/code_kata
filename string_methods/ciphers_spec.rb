require 'rspec'
require_relative 'ciphers'

RSpec.describe String do
  describe '#caesar' do
    subject { 'Hello World!' }
    it 'Basic shift works' do
      expect(subject.caesar).to eql('Ifmmp Xpsme!')
    end
    it 'Passing an offset parameter works' do
      expect(subject.caesar(2)).to eql('Jgnnq Yqtnf!')
    end
    it 'Passing a negative offset parameter works' do
      expect(subject.caesar(-1)).to eql('Gdkkn Vnqkc!')
    end
    it 'Copes (modulus) with offsets greater than 1' do
      expect(subject.caesar(27)).to eql('Ifmmp Xpsme!')
    end
  end
end
