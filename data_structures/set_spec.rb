require 'rspec'
require_relative 'set'

RSpec.describe Set do
  describe '#initialize' do
    it 'Creates a set object' do
      expect(Set.new.class).to eql(Set)
    end
  end
  describe '#length' do
    it 'Returns 0 for empty set' do
      expect(Set.new.length).to eql(0)
    end
    it 'Returns correct number for set created with array of unique values' do
      expect(Set.new([0, 1, 2, 3]).length).to eql(4)
    end
    it 'Returns correct number for set created with array of non-unique values' do
      expect(Set.new([0, 1, 1, 2]).length).to eql(3)
    end
  end
end
