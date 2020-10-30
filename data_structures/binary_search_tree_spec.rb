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
    it 'should work when repeated values passed' do
      repeat_tree = BinarySearchTree.new
      %w[h e e l o w l r d].each { |letter| repeat_tree.insert(letter) }
      expect(repeat_tree.count).to eql(7)
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
      array.each { |num| array_tree.insert(num) }
      expect(array_tree.to_a).to eql(array.sort)
    end
  end
  describe '#in_order' do
    in_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(in_tree.in_order).to eql([])
    end
    it 'should return an array of the elements in sorted order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| in_tree.insert(num) }
      expect(in_tree.in_order).to eql(array.sort)
    end
    it 'should work for an example from Wikipedia in case I got mine wrong' do
      array = %w[F B G A D I C E H]
      new_tree = BinarySearchTree.new
      array.each { |letter| new_tree.insert(letter) }
      expect(new_tree.in_order).to eql(%w[A B C D E F G H I])
    end
  end
  describe '#pre_order' do
    pre_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(pre_tree.pre_order).to eql([])
    end
    it 'should return an array of the elements in the correct order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| pre_tree.insert(num) }
      expect(pre_tree.pre_order).to eql([10, 6, 4, 3, 5, 8, 14, 12, 16, 20])
    end
    it 'should work for an example from Wikipedia in case I got mine wrong' do
      array = %w[F B G A D I C E H]
      new_tree = BinarySearchTree.new
      array.each { |letter| new_tree.insert(letter) }
      expect(new_tree.pre_order).to eql(%w[F B A D C E G I H])
    end
  end
  describe '#post_order' do
    post_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(post_tree.post_order).to eql([])
    end
    it 'should return an array of the elements in the correct order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| post_tree.insert(num) }
      expect(post_tree.post_order).to eql([3, 5, 4, 8, 6, 12, 20, 16, 14, 10])
    end
    it 'should work for an example from Wikipedia in case I got mine wrong' do
      array = %w[F B G A D I C E H]
      new_tree = BinarySearchTree.new
      array.each { |letter| new_tree.insert(letter) }
      expect(new_tree.post_order).to eql(%w[A C E D B H I G F])
    end
  end
  describe '#bf_order' do
    bf_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(bf_tree.bf_order).to eql([])
    end
    it 'should return an array of the elements in sorted order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| bf_tree.insert(num) }
      expect(bf_tree.bf_order).to eql([10, 6, 14, 4, 8, 12, 16, 3, 5, 20])
    end
  end
  describe '#full?' do
    full_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(full_tree.full?).to eql(true)
    end
    it 'should return true for a tree with just a root' do
      full_tree.insert(10)
      expect(full_tree.full?).to eql(true)
    end
    it 'should return false when appropriate in complex cases' do
      [5, 15, 2, 7, 6].each { |num| full_tree.insert(num) }
      expect(full_tree.full?).to eql(false)
    end
    it 'should return true when appropriate in complex cases' do
      full_tree.insert(8)
      expect(full_tree.full?).to eql(true)
    end
  end
  describe '#height' do
    height_tree = BinarySearchTree.new
    it 'should return 0 for an empty tree' do
      expect(height_tree.height).to eql(0)
    end
    it 'should return 1 for a tree with just a root' do
      height_tree.insert(10)
      expect(height_tree.height).to eql(1)
    end
    it 'should return the correct value for a larger tree' do
      [5, 2, 7, 8, 15].each { |num| height_tree.insert(num) }
      expect(height_tree.height).to eql(4)
    end
  end
  describe '#level' do
    level_tree = BinarySearchTree.new
    [10, 5, 15, 6, 7].each { |num| level_tree.insert(num) }
    it 'should return 1 for the root' do
      expect(level_tree.level(10)).to eql(1)
    end
    it 'should return the correct value for other nodes' do
      expect(level_tree.level(6)).to eql(3)
    end
    it 'should return nil for a value not in the tree' do
      expect(level_tree.level(8)).to eql(nil)
    end
  end
  describe '#complete?' do
    it 'is a pending example'
  end
  describe '#perfect?' do
    it 'is a pending example'
  end
  describe '#balanced?' do
    balanced_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(balanced_tree.balanced?).to eql(true)
    end
    it 'should return true for a tree with just a root' do
      balanced_tree.insert(10)
      expect(balanced_tree.balanced?).to eql(true)
    end
    it 'should return true for a balanced tree' do
      [5, 3, 15].each { |num| balanced_tree.insert(num) }
      expect(balanced_tree.balanced?).to eql(true)
    end
    it 'should return false for a non-balanced tree' do
      balanced_tree.insert(4)
      expect(balanced_tree.balanced?).to eql(false)
    end
  end
  describe '#degenerate?' do
    degenerate_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(degenerate_tree.degenerate?).to eql(true)
    end
    it 'should return true for a tree with just a root' do
      degenerate_tree.insert(10)
      expect(degenerate_tree.degenerate?).to eql(true)
    end
    it 'should return true when appropriate in complex cases' do
      [5, 6, 7].each { |num| degenerate_tree.insert(num) }
      expect(degenerate_tree.degenerate?).to eql(true)
    end
    it 'should return false when appropriate in complex cases' do
      degenerate_tree.insert(4)
      expect(degenerate_tree.degenerate?).to eql(false)
    end
  end
end
