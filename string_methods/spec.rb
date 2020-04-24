require 'rspec'
require_relative 'string_methods'

RSpec.describe String do
  describe '#abbreviate' do
    it 'Works in basic cases' do
      expect('British Broadcasting Corporation'.abbreviate).to eql('BBC')
    end
    it 'Can cope with random spaces' do
      expect('  Lord of  the Rings '.abbreviate).to eql('LotR')
    end
    it 'Can cope with an empty string' do
      expect(''.abbreviate).to eql('')
    end
  end
end
