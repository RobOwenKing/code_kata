require 'rspec'
require_relative 'binary_search_tree'

RSpec.describe BinarySearchTree do
  describe '#initialize' do
    it 'should work when passed no value' do
      expect(BinarySearchTree.new().root).to eql(nil)
    end
    it 'should work when passed a value' do
      expect(BinarySearchTree.new('Hi').root.value).to eql('Hi')
    end
  end
  describe '#insert' do
    insert_tree = BinarySearchTree.new()
    it "should give a tree a root when it doesn't have one" do
      insert_tree.insert(10)
      expect(insert_tree.root.value).to eql(10)
    end
    it 'should give root node a left child when passed a smaller value' do
      insert_tree.insert(1)
      expect(insert_tree.root.left.value).to eql(1)
    end
    it 'should give root node a right child when passed a larger value' do
      insert_tree.insert(100)
      expect(insert_tree.root.right.value).to eql(100)
    end
    it 'should place values in the correct place further down the tree' do
      insert_tree.insert(5)
      expect(insert_tree.root.left.right.value).to eql(5)
    end
    it 'should not add repeat values to the tree' do
      insert_tree.insert(100)
      expect(insert_tree.root.right.left).to eql(nil)
      expect(insert_tree.root.right.right).to eql(nil)
    end
    it 'should return nil when passed a repeated value' do
      expect(insert_tree.insert(1)).to eql(nil)
    end
    it 'should return a node otherwise' do
      expect(insert_tree.insert(200).class).to eql(Node)
    end
    it 'should return a node with the value passed in' do
      expect(insert_tree.insert(300).value).to eql(300)
    end
  end
end
