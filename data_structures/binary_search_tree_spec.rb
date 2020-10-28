require 'rspec'
require_relative 'binary_search_tree'

RSpec.describe BinarySearchTree do
  describe '#initialize' do
    it 'should work when passed no value' do
      expect(BinarySearchTree.new.root).to eql(nil)
    end
    it 'should work when passed a value' do
      expect(BinarySearchTree.new('Hi').root.value).to eql('Hi')
    end
  end
  describe '#insert' do
    insert_tree = BinarySearchTree.new
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
    count_tree = BinarySearchTree.new
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
  describe '#min' do
    min_tree = BinarySearchTree.new
    it 'should return nil when root is nil' do
      expect(min_tree.min).to eql(nil)
    end
    it 'should return root when root.left is nil' do
      min_tree.insert('m')
      min_tree.insert('t')
      expect(min_tree.min).to eql('m')
    end
    it 'should return correct value for more complex cases' do
      min_tree.insert('j')
      min_tree.insert('l')
      min_tree.insert('d')
      expect(min_tree.min).to eql('d')
    end
  end
  describe '#max' do
    max_tree = BinarySearchTree.new
    it 'should return nil when root is nil' do
      expect(max_tree.max).to eql(nil)
    end
    it 'should return root when root.right is nil' do
      max_tree.insert('m')
      expect(max_tree.max).to eql('m')
    end
    it 'should return correct value for more complex cases' do
      %w[w o e i f n z y].each { |letter| max_tree.insert(letter) }
      expect(max_tree.max).to eql('z')
    end
  end
  describe '#find' do
    find_tree = BinarySearchTree.new
    %w[m j k d l q r p].each { |letter| find_tree.insert(letter) }
    it 'should return a node when the value is in the tree' do
      expect(find_tree.find('k').class).to eql(Node)
    end
    it 'should return a node with the right value' do
      expect(find_tree.find('k').value).to eql('k')
    end
    it 'should return nil for a value not in the tree (within range)' do
      expect(find_tree.find('h')).to eql(nil)
    end
    it 'should return nil for a value not in the tree (outside range)' do
      expect(find_tree.find('a')).to eql(nil)
    end
  end
  describe '#floor' do
    floor_tree = BinarySearchTree.new
    [10, 6, 4, 8, 14, 12, 16].each { |num| floor_tree.insert(num) }
    it 'should return the value when it matches the root' do
      expect(floor_tree.floor(10)).to eql(10)
    end
    it 'should return the value when it matches another node' do
      expect(floor_tree.floor(14)).to eql(14)
    end
    it 'should work for a value within the range of the tree (returning root)' do
      expect(floor_tree.floor(11)).to eql(10)
    end
    it 'should work for a value within the range of the tree (returning other)' do
      expect(floor_tree.floor(13)).to eql(12)
    end
    it 'should work for a value above the range of the tree' do
      expect(floor_tree.floor(20)).to eql(16)
    end
    it 'should return nil for a value below the range of the tree' do
      expect(floor_tree.floor(2)).to eql(nil)
    end
  end
  describe '#ceil' do
    ceil_tree = BinarySearchTree.new
    [10, 6, 4, 8, 14, 12, 16].each { |num| ceil_tree.insert(num) }
    it 'should return the value when it matches the root' do
      expect(ceil_tree.ceil(10)).to eql(10)
    end
    it 'should return the value when it matches another node' do
      expect(ceil_tree.ceil(14)).to eql(14)
    end
    it 'should work for a value within the range of the tree (returning root)' do
      expect(ceil_tree.ceil(9)).to eql(10)
    end
    it 'should work for a value within the range of the tree (returning other)' do
      expect(ceil_tree.ceil(13)).to eql(14)
    end
    it 'should work for a value below the range of the tree' do
      expect(ceil_tree.ceil(2)).to eql(4)
    end
    it 'should return nil for a value above the range of the tree' do
      expect(ceil_tree.ceil(20)).to eql(nil)
    end
  end
  describe '#to_a' do
    array_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(array_tree.to_a).to eql([])
    end
    it 'should return an array of the elements in sorted order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| ceil_tree.insert(num) }
      expect(array_tree.to_a).to eql(array.sort)
    end
  end
end
