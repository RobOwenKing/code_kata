# frozen_string_literal: true

require 'rspec'
require_relative 'min_heap'

RSpec.describe MinHeap do
  describe '#insert' do
    insert_heap = MinHeap.new
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
  describe '#delete' do
    delete_heap = MinHeap.new
    [10, 11, 12, 13, 14, 15, 16, 17, 18].each { |num| delete_heap.insert(num) }
    it 'should correctly delete the final leaf' do
      delete_heap.delete(18)
      expect(delete_heap.to_a).to eql([10, 11, 12, 13, 14, 15, 16, 17])
    end
    it 'should correctly delete other leaves' do
      delete_heap.delete(15)
      expect(delete_heap.to_a).to eql([10, 11, 12, 13, 14, 17, 16])
    end
    it 'should correctly delete intermediate nodes' do
      delete_heap.delete(11)
      expect(delete_heap.to_a).to eql([10, 13, 12, 16, 14, 17])
    end
    it 'should correctly delete the root' do
      delete_heap.delete(10)
      expect(delete_heap.to_a).to eql([12, 13, 17, 16, 14])
    end
  end
end
