require 'rspec'
require_relative 'linked_lists'

RSpec.describe Node do
  describe '#initialize' do
    it 'Should create a node with the given #value' do
      expect(Node.new('Test').value).to eql('Test')
    end
    it 'Should have #next nil if no node given' do
      expect(Node.new('Test').next).to eql(nil)
    end
    it 'Should have correct #next node if given' do
      node1 = Node.new('Test')
      node2 = Node.new('Next test', node1)
      expect(node2.next).to eql(node1)
    end
    it 'Should raise an error if given #next node is of wrong type' do
      expect { Node.new('Oops', 'a daisy') }.to raise_error(ArgumentError)
    end
  end
end

RSpec.describe LinkedList do
  describe '#initialize' do
    linked_list = LinkedList.new('Test')
    it 'If passed a value, #head should be a node' do
      expect(linked_list.head.class).to eql(Node)
    end
    it 'The value of that node should match the value given' do
      expect(linked_list.head.value).to eql('Test')
    end
    it 'Should have #head nil if none given' do
      expect(LinkedList.new.head).to eql(nil)
    end
    it '#first should return value of #head' do
      expect(linked_list.first).to eql(linked_list.head.value)
    end
  end
  describe '#unshift' do
    unshift_list = LinkedList.new('100')
    unshift_list.unshift('200')
    it "Should change the value of the list's head" do
      expect(unshift_list.first).to eql('200')
    end
    it 'Should move the previous head to second position' do
      expect(unshift_list.head.next.value).to eql('100')
    end
    empty_list = LinkedList.new
    empty_list.unshift('300')
    it 'Should create head if none exists' do
      expect(empty_list.first).to eql('300')
    end
    it 'Should have nil as second item' do
      expect(empty_list.head.next).to eql(nil)
    end
  end
  describe '#shift' do
    shift_list = LinkedList.new('100')
    shift_list.unshift('200')
    shift_list.unshift('300')
    it "Should return the value of the list's head" do
      expect(shift_list.first).to eql(shift_list.shift)
    end
    it 'Should remove the head from the list' do
      expect(shift_list.shift).to_not eql(shift_list.first)
    end
  end
  describe '#tail' do
    tail_list = LinkedList.new
    it 'Should return nil if the list is empty' do
      expect(tail_list.tail).to eql(nil)
    end
    it 'Should return the head for a list length 1' do
      tail_list.unshift('100')
      expect(tail_list.tail).to eql(tail_list.head)
    end
    it 'Should return the correct value for a list with more items' do
      tail_list.unshift('200')
      tail_list.unshift('300')
      expect(tail_list.tail.value).to eql('100')
    end
  end
  describe '#last' do
    last_list = LinkedList.new
    last_list.unshift('100')
    last_list.unshift('200')
    it 'Should return the value of #tail' do
      expect(last_list.last).to eql(last_list.tail.value)
    end
  end
  describe '#push' do
    push_list = LinkedList.new
    it 'Should work for an empty list' do
      push_list.push('100')
      expect(push_list.last).to eql(push_list.first)
    end
    it 'Should work for longer lists' do
      push_list.push('200')
      push_list.push('300')
      expect(push_list.last).to eql('300')
    end
  end
  describe '#pop' do
    pop_list = LinkedList.new
    it 'Should return nil if the list is empty' do
      expect(pop_list.pop).to eql(nil)
    end
    it "Should return the value of the list's tail" do
      pop_list.push('100')
      pop_list.push('200')
      pop_list.push('300')
      expect(pop_list.last).to eql(pop_list.pop)
    end
    it 'Should remove the tail from the list' do
      expect(pop_list.pop).to_not eql(pop_list.last)
    end
  end
  describe '#length' do
    length_list = LinkedList.new
    it 'Should return 0 if the head is nil' do
      expect(length_list.length).to eql(0)
    end
    it 'Should work for a list of length 1' do
      length_list.push('100')
      expect(length_list.length).to eql(1)
    end
    it 'Should work for a longer list' do
      length_list.push('200')
      length_list.push('300')
      expect(length_list.length).to eql(3)
    end
  end
  describe '#fetch' do
    fetch_list = LinkedList.new
    fetch_list.push('100')
    fetch_list.push('200')
    fetch_list.push('300')
    fetch_list.push('400')
    it 'Should return the first for fetch(0)' do
      expect(fetch_list.fetch(0)).to eql(fetch_list.first)
    end
    it 'Should return the correct value for an index in the middle' do
      expect(fetch_list.fetch(2)).to eql('300')
    end
    it 'Should return the correct value for the tail' do
      expect(fetch_list.fetch(3)).to eql(fetch_list.last)
    end
    it 'Should return nil when the index is too large' do
      expect(fetch_list.fetch(10)).to eql(nil)
    end
    it 'Should handle negative indices' do
      expect(fetch_list.fetch(-1)).to eql(fetch_list.last)
    end
  end
end
