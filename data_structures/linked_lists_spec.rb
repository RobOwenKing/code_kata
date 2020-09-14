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
