require 'rspec'
require_relative 'heap'

RSpec.describe Heap do
  describe '#insert' do
    insert_heap = Heap.new
    it 'should insert a root when the heap is empty' do
      insert_heap.insert(2)
      expect(insert_heap.root).to eql(2)
    end
    it 'should insert larger values as a leaf' do
      [4, 5, 6].each { |num| insert_heap.insert(num) }
      expect(insert_heap.to_a).to eql([2, 4, 5, 6])
    end
    it 'should bubble the smallest value to the root' do
      insert_heap.insert(1)
      expect(insert_heap.root).to eql(1)
    end
    it 'should bubble other values part way' do
      insert_heap.insert(3)
      expect(insert_heap.to_a).to eql([1, 2, 3, 6, 4, 5])
    end
  end
end
