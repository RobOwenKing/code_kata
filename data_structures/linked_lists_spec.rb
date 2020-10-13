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
    it '#first should work as an alias of #head' do
      expect(linked_list.first).to eql(linked_list.head)
    end
  end
  describe '#unshift' do
    linked_list = LinkedList.new('100')
    linked_list.unshift('200')
    it "Should change the value of the list's head" do
      expect(linked_list.head.value).to eql('200')
    end
    it 'Should move the previous head to second position' do
      expect(linked_list.head.next.value).to eql('100')
    end
end
