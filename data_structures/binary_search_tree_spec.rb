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
  describe '#delete' do
    delete_tree = BinarySearchTree.new
    nodes = [10, 5, 3, 7, 2, 4, 9, 8, 15, 12, 17, 16, 18]
    nodes.each { |num| delete_tree.insert(num) }
    it 'should return nil for a value not in the tree' do
      expect(delete_tree.delete(100)).to eql(nil)
    end
    it 'should return the deleted value' do
      expect(delete_tree.delete(4)).to eql(4)
    end
    it 'should delete a leaf' do
      expect(delete_tree.find(4)).to eql(nil)
    end
    it 'should reduce the size of the tree by 1' do
      expect(delete_tree.count).to eql(nodes.size - 1)
    end
    it 'should delete a node with just a left child' do
      delete_tree.delete(3)
      expect(delete_tree.find(3)).to eql(nil)
    end
    it 'should reduce the size of the tree by 1' do
      expect(delete_tree.count).to eql(nodes.size - 2)
    end
    it "shouldn't disconnect the child" do
      expect(delete_tree.find(2).class).to eql(Node)
    end
    it 'should delete a node with just a right child' do
      delete_tree.delete(7)
      expect(delete_tree.find(7)).to eql(nil)
    end
    it 'should reduce the size of the tree by 1' do
      expect(delete_tree.count).to eql(nodes.size - 3)
    end
    it "shouldn't disconnect the child" do
      expect(delete_tree.find(9).class).to eql(Node)
    end
    it 'should leave the tree in sorted order' do
      expect(delete_tree.to_a.sort).to eql(delete_tree.to_a)
    end
    it 'should delete a node with just a right child' do
      delete_tree.delete(15)
      expect(delete_tree.find(15)).to eql(nil)
    end
    it 'should reduce the size of the tree by 1' do
      expect(delete_tree.count).to eql(nodes.size - 4)
    end
    it "shouldn't disconnect children" do
      expect(delete_tree.find(12).class).to eql(Node)
    end
    it "shouldn't disconnect children" do
      expect(delete_tree.find(18).class).to eql(Node)
    end
    it 'should leave the tree in sorted order' do
      expect(delete_tree.to_a.sort).to eql(delete_tree.to_a)
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
  describe '#subtree' do
    subtree_tree = BinarySearchTree.new
    [10, 6, 4, 8, 7, 9, 14, 12, 16].each { |num| subtree_tree.insert(num) }
    subtree1 = subtree_tree.subtree(6)
    it "should return nil when the value passed isn't found" do
      expect(subtree_tree.subtree(2)).to eql(nil)
    end
    it 'should return a tree if the value is found' do
      expect(subtree1.class).to eql(BinarySearchTree)
    end
    it 'should have the correct size' do
      expect(subtree1.count).to eql(5)
    end
    it 'should include appropriate nodes' do
      expect(subtree1.find(7)).to be_truthy
    end
    it 'should not include other nodes from the original' do
      expect(subtree1.find(14)).to be_falsy
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
  describe '#parent' do
    parent_tree = BinarySearchTree.new
    [10, 6, 4, 8, 14, 12, 16].each { |num| parent_tree.insert(num) }
    it 'should return nil for the root' do
      expect(parent_tree.parent(10)).to eql(nil)
    end
    it 'should return false for a value not in the tree' do
      expect(parent_tree.parent(2)).to eql(false)
    end
    it 'should work for a leaf' do
      expect(parent_tree.parent(12)).to eql(14)
    end
    it 'should work for an intermediary node' do
      expect(parent_tree.parent(6)).to eql(10)
    end
  end
  describe '#successor' do
    successor_tree = BinarySearchTree.new
    [10, 6, 4, 8, 7, 9, 14, 12, 16].each { |num| successor_tree.insert(num) }
    it 'should return nil when #max' do
      expect(successor_tree.successor(16)).to eql(nil)
    end
    it 'should return false for a value not in the tree' do
      expect(successor_tree.successor(2)).to eql(false)
    end
    it 'should return a right child which is a leaf' do
      expect(successor_tree.successor(14)).to eql(16)
    end
    it 'should return min value of right child subtree' do
      expect(successor_tree.successor(6)).to eql(7)
    end
    it 'should return parent when no right child (and self left child)' do
      expect(successor_tree.successor(4)).to eql(6)
    end
    it 'should return earlier parent when no right child (and self right child)' do
      expect(successor_tree.successor(9)).to eql(10)
    end
  end
  describe '#previous' do
    previous_tree = BinarySearchTree.new
    [10, 6, 4, 8, 7, 9, 14, 12, 16].each { |num| previous_tree.insert(num) }
    it 'should return nil when #max' do
      expect(previous_tree.previous(4)).to eql(nil)
    end
    it 'should return false for a value not in the tree' do
      expect(previous_tree.previous(2)).to eql(false)
    end
    it 'should return a left child which is a leaf' do
      expect(previous_tree.previous(6)).to eql(4)
    end
    it 'should return min value of left child subtree' do
      expect(previous_tree.previous(10)).to eql(9)
    end
    it 'should return parent when no left child (and self right child)' do
      expect(previous_tree.previous(16)).to eql(14)
    end
    it 'should return earlier parent when no left child (and self left child)' do
      expect(previous_tree.previous(12)).to eql(10)
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
  describe '#leaves' do
    in_tree = BinarySearchTree.new
    it 'should return an empty array for an empty tree' do
      expect(in_tree.leaves).to eql([])
    end
    it 'should return an array of the leaf elements in sorted order' do
      array = [10, 6, 4, 8, 14, 5, 12, 16, 3, 20]
      array.each { |num| in_tree.insert(num) }
      expect(in_tree.leaves).to eql([3, 5, 8, 12, 20])
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
    complete_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(complete_tree.complete?).to eql(true)
    end
    it 'should return true for a tree with only a root' do
      complete_tree.insert(10)
      expect(complete_tree.complete?).to eql(true)
    end
    it 'should return false when appropriate for a complex case' do
      [5, 7, 15].each { |num| complete_tree.insert(num) }
      expect(complete_tree.complete?).to eql(false)
    end
    it 'should return true when appropriate for a complex case' do
      complete_tree.insert(2)
      expect(complete_tree.complete?).to eql(true)
    end
  end
  describe '#perfect?' do
    perfect_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(perfect_tree.perfect?).to eql(true)
    end
    it 'should return true for a tree with only a root' do
      perfect_tree.insert(10)
      expect(perfect_tree.perfect?).to eql(true)
    end
    it 'should return false when appropriate for a complex case' do
      [5, 7, 15].each { |num| perfect_tree.insert(num) }
      expect(perfect_tree.perfect?).to eql(false)
    end
    it 'should return true when appropriate for a complex case' do
      [2, 12, 17].each { |num| perfect_tree.insert(num) }
      expect(perfect_tree.perfect?).to eql(true)
    end
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
  describe '#symmetric?' do
    symmetric_tree = BinarySearchTree.new
    it 'should return true for an empty tree' do
      expect(symmetric_tree.symmetric?).to eql(true)
    end
    it 'should return true for a tree with just a root' do
      symmetric_tree.insert(10)
      expect(symmetric_tree.symmetric?).to eql(true)
    end
    it 'should return false for a tree with a root with one child' do
      symmetric_tree.insert(3)
      expect(symmetric_tree.symmetric?).to eql(false)
    end
    it 'should return true for a tree with a root with two children' do
      symmetric_tree.insert(17)
      expect(symmetric_tree.symmetric?).to eql(true)
    end
    it 'should return false when appropriate in complex cases' do
      [1, 19, 8, 12, 9, 11, 5].each { |num| symmetric_tree.insert(num) }
      expect(symmetric_tree.symmetric?).to eql(false)
    end
    it 'should return true when appropriate in complex cases' do
      symmetric_tree.insert(15)
      expect(symmetric_tree.symmetric?).to eql(true)
    end
  end
  describe '#invert' do
    invertable_tree = BinarySearchTree.new
    inverted_tree = BinarySearchTree.new
    [10, 1, 19, 8, 12, 9, 11, 5].each do |num|
      invertable_tree.insert(num)
      inverted_tree.insert(num)
    end
    inverted_tree.invert
    it 'should have the same root node' do
      expect(invertable_tree.root.value).to eql(inverted_tree.root.value)
    end
    it 'should reverse the order of the nodes' do
      expect(invertable_tree.in_order.reverse).to eql(inverted_tree.in_order)
    end
  end
end
