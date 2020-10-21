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
      empty_set = Set.new
      expect(empty_set.length).to eql(0)
    end
    it 'Returns correct number for set created with array of unique values' do
      expect(Set.new([0, 1, 2, 3]).length).to eql(4)
    end
    it 'Returns correct number for set created with array of non-unique values' do
      expect(Set.new([0, 1, 1, 2]).length).to eql(3)
    end
  end
  describe '#add' do
    add_set = Set.new
    it 'Should add a new element to an empty set' do
      add_set.add(0)
      expect(add_set.length).to eq(1)
    end
    it 'Should add a new element to a non-empty set' do
      add_set.add(1)
      expect(add_set.length).to eq(2)
    end
    it "Shouldn't add a duplicate element" do
      add_set.add(1)
      expect(add_set.length).to eq(2)
    end
  end
  describe '#include?' do
    include_set = Set.new([0, 1, 2])
    it 'Should return true for an element in the set' do
      expect(include_set.include?(1)).to eq(true)
    end
    it 'Should return false for an element not in the set' do
      expect(include_set.include?(3)).to eq(false)
    end
  end
  describe '#delete' do
    delete_set = Set.new(%w[a b c])
    it 'Should return nil for an empty set' do
      expect(Set.new.delete(1)).to eql(nil)
    end
    it 'Should delete an element in the set' do
      delete_set.delete('b')
      expect(delete_set.length).to eql(2)
    end
    it 'Should return nil for an element not in the set' do
      expect(delete_set.delete('d')).to eql(nil)
    end
  end
  describe '#union' do
    union_set = Set.new([1, 2, 3])
    it 'Should work called on an empty set' do
      set_1 = Set.new.union(union_set)
      expect(set_1.length).to eql(3)
    end
    it 'Should work with the empty set as argument' do
      set_2 = union_set.union(Set.new)
      expect(set_2.length).to eql(3)
    end
    it 'Should work with two non-empty sets with no overlap' do
      set_3 = Set.new([4, 5])
      set_4 = union_set.union(set_3)
      expect(set_4.length).to eql(5)
    end
    it 'Should work with two non-empty sets with overlap' do
      set_5 = Set.new([4, 6])
      set_6 = union_set.union(set_5)
      expect(set_6.length).to eql(6)
    end
  end
end
