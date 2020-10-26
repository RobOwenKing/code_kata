require 'rspec'
require_relative 'binary_search_tree'

RSpec.describe BinarySearchTree do
  describe '#insert' do
    insert_tree = BinarySearchTree.new(10)
    insert_root = insert_tree.root
    it 'should give root node a left child when passed a smaller value' do
      insert_tree.insert(1)
      expect(insert_root.left.value).to eql(1)
    end
    it 'should give root node a right child when passed a larger value' do
      insert_tree.insert(100)
      expect(insert_root.right.value).to eql(100)
    end
    it 'should place values in the correct place further down the tree' do
      insert_tree.insert(5)
      expect(insert_root.left.right.value).to eql(5)
    end
    it 'should not add repeat values to the tree' do
      insert_tree.insert(100)
      expect(insert_root.right.left).to eql(nil)
      expect(insert_root.right.right).to eql(nil)
    end
    it 'should return nil when passed a repeated value' do
      expect(insert_tree.insert(5)).to eql(nil)
    end
    it 'should return a node otherwise' do
      expect(insert_tree.insert(200).class).to eql(Node)
    end
    it 'should return a node with the value passed in' do
      expect(insert_tree.insert(300).value).to eql(300)
    end
  end
end
