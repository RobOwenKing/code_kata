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
      set1 = Set.new.union(union_set)
      expect(set1.length).to eql(3)
    end
    it 'Should work with the empty set as argument' do
      set2 = union_set.union(Set.new)
      expect(set2.length).to eql(3)
    end
    it 'Should work with two non-empty sets with no overlap' do
      set3 = Set.new([4, 5])
      set4 = union_set.union(set3)
      expect(set4.length).to eql(5)
    end
    it 'Should work with two non-empty sets with overlap' do
      set5 = Set.new([4, 6])
      set6 = union_set.union(set5)
      expect(set6.length).to eql(6)
    end
  end
  describe '#intersection' do
    intersection_set = Set.new([1, 2, 3])
    it 'Should work called on an empty set' do
      set1 = Set.new.intersection(intersection_set)
      expect(set1.length).to eql(0)
    end
    it 'Should work with the empty set as argument' do
      set2 = intersection_set.intersection(Set.new)
      expect(set2.length).to eql(0)
    end
    it 'Should work with two non-empty sets with no overlap' do
      set3 = Set.new([4, 5])
      set4 = intersection_set.intersection(set3)
      expect(set4.length).to eql(0)
    end
    it 'Should work with two non-empty sets with overlap' do
      set5 = Set.new([2, 6])
      set6 = intersection_set.intersection(set5)
      expect(set6.length).to eql(1)
    end
  end
  describe '#intersection' do
    intersection_set = Set.new([1, 2, 3])
    it 'Should work called on an empty set' do
      set1 = Set.new.intersection(intersection_set)
      expect(set1.length).to eql(0)
    end
    it 'Should work with the empty set as argument' do
      set2 = intersection_set.intersection(Set.new)
      expect(set2.length).to eql(0)
    end
    it 'Should work with two non-empty sets with no overlap' do
      set3 = Set.new([4, 5])
      set4 = intersection_set.intersection(set3)
      expect(set4.length).to eql(0)
    end
    it 'Should work with two non-empty sets with overlap' do
      set5 = Set.new([2, 6])
      set6 = intersection_set.intersection(set5)
      expect(set6.length).to eql(1)
    end
  end
  describe '#difference' do
    difference_set = Set.new([1, 2, 3])
    it 'Should work called on an empty set' do
      set1 = Set.new.difference(difference_set)
      expect(set1.length).to eql(0)
    end
    it 'Should work with the empty set as argument' do
      set2 = difference_set.difference(Set.new)
      expect(set2.length).to eql(3)
    end
    it 'Should work with two non-empty sets with no overlap' do
      set3 = Set.new([4, 5])
      set4 = difference_set.difference(set3)
      expect(set4.length).to eql(3)
    end
    it 'Should work with two non-empty sets with overlap' do
      set5 = Set.new([2, 6])
      set6 = difference_set.difference(set5)
      expect(set6.length).to eql(2)
    end
  end
  describe '#subset?' do
    subset_set = Set.new([1, 2, 3])
    it 'Should return false called on an empty set' do
      expect(Set.new.subset?(subset_set)).to eql(false)
    end
    it 'Should return true with the empty set as argument' do
      expect(subset_set.subset?(Set.new)).to eql(true)
    end
    it 'Should return false with two non-empty sets with no overlap' do
      set1 = Set.new([4, 5])
      expect(subset_set.subset?(set1)).to eql(false)
    end
    it 'Should return false with two non-empty sets with some overlap' do
      set2 = Set.new([2, 6])
      expect(subset_set.subset?(set2)).to eql(false)
    end
    it 'Should return true when the argument is a subset' do
      set3 = Set.new([1, 3])
      expect(subset_set.subset?(set3)).to eql(true)
    end
  end
end
