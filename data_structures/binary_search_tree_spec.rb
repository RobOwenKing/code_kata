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
  describe '#include?' do
    include_tree = BinarySearchTree.new('r')
    %w[o b e t].each { |letter| include_tree.insert(letter) }
    it 'should return true for a value in the tree' do
      expect(include_tree.include?('b')).to eql(true)
    end
    it 'should return false for a value not in the tree' do
      expect(include_tree.include?('c')).to eql(false)
    end
  end
  describe '#count' do
    count_tree = BinarySearchTree.new()
    it 'should return 0 when root is nil' do
      expect(count_tree.count).to eql(0)
    end
    it 'should return 1 for a tree with just a root' do
      count_tree.insert('h')
      expect(count_tree.count).to eql(1)
    end
    it 'should work for larger trees' do
      %w[e l o w r d].each { |letter| count_tree.insert(letter) }
      expect(count_tree.count).to eql(7)
    end
  end
end
