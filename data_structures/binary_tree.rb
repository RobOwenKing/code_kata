# frozen_string_literal: true

# A Binary Tree class implemented in Ruby

# Contents
# class Binary Tree
# - Binary Tree
# - - - #initialize
# - - Basic Crud
# - - - #insert(value)
# - - - #find(value)
# - - Tree Manipulation
# - - - #invert!
# - - - #to_searchable!
# - - - #balance!
# - - Printing
# - - - #to_a
# - - - #in_order
# - - - #pre_order
# - - - #post_order
# - - - #leaves
# - - - #bf_order
# - - Properties (Values)
# - - - #sum?
# - - - #searchable?
# - - Properties (Structure)
# - - - #full?
# - - - #complete?
# - - - #perfect?
# - - - #balanced?
# - - - #degenerate?
# - - - #symmetric?
# - Binary Search Tree
# - - Searchable Basic CRUD
# - - - #s_insert(value)
# - - - #s_find(value)
# - - - #s_include?(value)
# - - Searchable Finding Values
# - - - #s_min
# - - - #s_max

# Note: Methods prefixed s_ are for a Binary Search Tree
# They will as such often be faster than the regular methods
# But won't work correctly and/or will break if the tree is not #searchable?

# Methods after #Unsorted are not updated since this stopped being purely a Binary Search Tree class
# As such they should be used with great care on trees that aren't #searchable?

# Import the Node class we'll use
require_relative 'binary_tree_node'
# Import constants (holding functions to call upon traversal)
require_relative 'binary_tree_constants'
# We'll use a queue for the breadth-first ordering
require_relative 'queue'

# Binary Tree class
class BinaryTree
  attr_accessor :root

  def initialize(value = nil)
    @root = value.nil? ? nil : Node.new(value)
  end

  # Basic CRUD

  # Insert the value in the next free space (breadth-first order)
  # Note: Allows for insertion of duplicate values
  def insert(value)
    # Create the node, then work out where it goes
    new_node = Node.new(value)
    # If there's no root, it should be the root
    return @root = new_node if @root.nil?

    # As in BF order (below), we'll use a queue to iterate through the tree
    queue = MyQueue.new
    queue.enqueue(@root)

    until queue.empty?
      current = queue.dequeue
      return current.left = new_node if current.left.nil?
      return current.right = new_node if current.right.nil?

      queue.enqueue(current.left)
      queue.enqueue(current.right)
    end
  end

  def find(value)
    return nil if @root.nil?

    queue = MyQueue.new
    queue.enqueue(@root)

    until queue.empty?
      current = queue.dequeue
      return current if current.value == value

      queue.enqueue(current.left) unless current.left.nil?
      queue.enqueue(current.right) unless current.right.nil?
    end

    nil
  end

  # Tree Manipulation

  # Replaces the tree with its mirror image
  def invert!
    @root&.swap
  end

  # Maintains the tree's structure but puts the values into order
  def to_searchable!
    values = to_a.sort
    order = %w[left root right]
    action = proc { |node, returnable| node.value = returnable.shift }
    root.nil? ? [] : traverse(@root, order, values, action)
  end

  def balance!
    return nil if root.nil?

    values = to_a

    @root = balance_insert(values)
  end

  # Printing

  # Returns a array of the values of the tree's nodes
  def to_a
    order = %w[left root right]
    action = proc { |node, returnable| returnable << node.value }
    root.nil? ? [] : traverse(@root, order, [], action)
  end

  # Alias of #to_a
  def in_order
    to_a
  end

  # Returns a pre-ordered array of the values of the tree's nodes
  def pre_order
    order = %w[root left right]
    action = proc { |node, returnable| returnable << node.value }
    root.nil? ? [] : traverse(@root, order, [], action)
  end

  # Returns a post-ordered array of the values of the tree's nodes
  def post_order
    order = %w[left right root]
    action = proc { |node, returnable| returnable << node.value }
    root.nil? ? [] : traverse(@root, order, [], action)
  end

  # Returns a array of the values of the tree's leaves (from left to right)
  def leaves
    order = %w[left root right]
    action = proc { |node, returnable| returnable << node.value if node.left.nil? && node.right.nil? }
    root.nil? ? [] : traverse(@root, order, [], action)
  end

  # Returns an array of the values of the tree's nodes (breadth-first order)
  def bf_order
    order = []
    queue = MyQueue.new
    @root.nil? ? order : queue.enqueue(@root)

    until queue.empty?
      current = queue.dequeue
      queue.enqueue(current.left) unless current.left.nil?
      queue.enqueue(current.right) unless current.right.nil?
      order << current.value
    end

    order
  end

  # Properties (Values)

  # Returns whether the tree is a Sum Tree or not
  # i.e. Whether its value equals the sum of the values in its left and right subtrees
  def sum?
    return true if @root.nil?

    !!@root.iterate(SUM)
  end

  # Returns whether its a Binary Search Tree or not
  # i.e. Whether for each node, every node in its left subtree is smaller & vice-vice for right
  def searchable?
    return true if @root.nil?

    !!@root.iterate(SEARCHABLE)
  end

  # Properties (Structure)

  # Tests whether the tree is full
  # eg: Whether every node has either 0 or 2 children
  def full?
    # Define as true if tree empty, else start iterating
    # @root.nil? ? true : @root.full?
    @root.nil? ? true : @root.iterate(FULL)
  end

  # Tests whether the tree is complete
  # eg: Whether every level is complete except possibly the last level...
  # ... and all nodes in the last level are as far left as possible
  def complete?
    return true if @root.nil?

    queue = []
    current = @root

    until current.nil?
      queue.push(current.left)
      queue.push(current.right)
      current = queue.shift
    end

    queue.all?(&:nil?)
  end

  # Tests whether the tree is perfect
  # eg: Whether every non-leaf node has precisely two children
  def perfect?
    return true if @root.nil?
    return false unless complete?

    (count + 1).to_s(2).count('1') == 1
  end

  def balanced?
    @root.nil? ? true : @root.iterate(BALANCED)
  end

  def degenerate?
    @root.nil? ? true : @root.iterate(DEGENERATE)
  end

  def symmetric?
    return true if @root.nil?

    mirror?(@root.left, @root.right)
  end

  # Binary Search Tree

  # Searchable Basic CRUD

  # Add a value to the tree
  # Returns new Node
  # Repeat values not added, return nil
  def s_insert(value)
    # Find where the given value would go in the tree
    parent_node = @root.nil? ? nil : @root.s_find_node(value)
    # If that would repeat a value, return nil
    return nil if !parent_node.nil? && parent_node.value == value

    # Else, we're adding a node
    new_node = Node.new(value)
    # If no root, put the new node there
    return @root = new_node if @root.nil?

    # Else place the node in the relevant child position
    value < parent_node.value ? parent_node.left = new_node : parent_node.right = new_node
  end

  # Returns the node from the tree with the given value
  # Returns nil if no such node in the tree
  def s_find(value)
    found_node = @root.s_find_node(value)
    found_node.value == value ? found_node : nil
  end

  # Test whether a given value is in the tree
  # Returns boolean
  def s_include?(value)
    return false if @root.nil?

    found_node = @root.s_find_node(value)
    found_node.value == value
  end

  # Deletes node with given value and returns that value
  # If no such node, returns nil
  # The algorithm maintains tree connectedness and sortedness (if sorted)
  def delete(value)
    node = s_find(value)
    return nil if node.nil?

    if node.left.nil? && node.right.nil?
      delete_leaf(node)
    else
      delete_with_child(node)
    end
  end

  # Searchable Finding Values

  # Return the minimum value of any node in the tree
  # Returns nil for an empty tree
  def s_min
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.left until current_node.left.nil?
    current_node.value
  end

  # Return the maximum value of any node in the tree
  # Returns nil for an empty tree
  def s_max
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.right until current_node.right.nil?
    current_node.value
  end





  # Unsorted

  # Returns the value of the parent node of the node with the passed value
  # Returns nil if the value matches the root
  # Returns false if there is no node with the given value
  def parent(value)
    return nil if @root.value == value

    found_node = @root.s_find_parent(value)
    !found_node ? false : found_node.value
  end

  # Returns the largest value in the tree smaller than the passed value
  # Returns nil if no such value found
  def floor(value)
    # We're going to use a private method which also takes a node as input
    # This allows us to use recursion
    # We evaluate here to avoid bringing nil into comparisons in #find_floor
    best_find = find_floor(value, @root)
    best_find > value ? nil : best_find
  end

  # Returns the smallest value in the tree larger than the passed value
  # Returns nil if no such value found
  def ceil(value)
    # Based on #floor
    best_find = find_ceil(value, @root)
    best_find < value ? nil : best_find
  end

  # Returns the number of nodes in the tree (integer)
  def count
    # Quick fix
    # Would be better to count while traversing rather than building array then counting that
    to_a.count
  end

  # Returns a new Binary Tree but the nodes are the same
  # This means altering the subtree will affect (and may break) the original
  # New tree's root node is the node of original tree with passed value
  def subtree(value)
    node = s_find(value)
    if node.nil?
      nil
    else
      tree = BinaryTree.new
      tree.root = node
      tree
    end
  end

  # Returns the next value in the tree larger than the passed value
  # Returns nil if no larger value found
  # Returns false if no node found with the passed value
  def successor(value)
    node = s_find(value)
    return false if node.nil?

    # If the node has a right subtree, its minimum value will be next largest
    return subtree(node.right.value).s_min unless node.right.nil?

    current_parent = parent(node.value)
    until s_find(current_parent).left.value == node.value
      node = s_find(current_parent)
      current_parent = parent(node.value)
      return nil if current_parent.nil?
    end
    current_parent
  end

  # Returns the next value in the tree smaller than the passed value
  # Returns nil if no smaller value found
  # Returns false if no node found with the passed value
  def previous(value)
    node = s_find(value)
    return false if node.nil?

    # If the node has a left subtree, its maximum value will be next smallest
    return subtree(node.left.value).s_max unless node.left.nil?

    current_parent = parent(node.value)
    until s_find(current_parent).right.value == node.value
      node = s_find(current_parent)
      current_parent = parent(node.value)
      return nil if current_parent.nil?
    end
    current_parent
  end

  # Returns the number of levels in the tree with any nodes (integer)
  # eg: 1 for a tree with just a root, 2 if only the root has children, etc
  def height
    # @root.nil? ? 0 : @root.height
    @root.nil? ? 0 : @root.iterate(HEIGHT)
  end

  # Returns the level in the tree where the node with the passed value is (integer)
  # eg: Returns 1 if passed the root's value, 2 if passed one of its children's values, etc
  # Returns nil if there is no node with passed value
  def level(value)
    current_node = @root
    tracker = 1

    until current_node.nil? || current_node.value == value
      tracker += 1
      current_node = current_node.value < value ? current_node.right : current_node.left
    end

    current_node.nil? ? nil : tracker
  end

  private

  def find_floor(value, node)
    return value if node.value == value

    if node.value > value
      # If this node's value is too big, look for a smaller one if possible
      node.left.nil? ? node.value : find_floor(value, node.left)
    else
      # Now we're small enough, so we see if there's anything bigger possible
      best_find = node.right.nil? ? node.value : find_floor(value, node.right)
      # If everything in the right subtree's too big, this node's value is the floor
      best_find > value ? node.value : best_find
    end
  end

  # Based on #find_floor
  def find_ceil(value, node)
    return value if node.value == value

    if node.value < value
      node.right.nil? ? node.value : find_ceil(value, node.right)
    else
      best_find = node.left.nil? ? node.value : find_ceil(value, node.left)
      best_find < value ? node.value : best_find
    end
  end

  def traverse(node, order, returnable, action)
    order.each do |current|
      if current == 'left' && !node.left.nil?
        returnable = traverse(node.left, order, returnable, action)
      elsif current == 'right' && !node.right.nil?
        returnable = traverse(node.right, order, returnable, action)
      elsif current == 'root'
        action.call(node, returnable)
      end
    end
    returnable
  end

  def delete_leaf(node)
    if node == @root
      # If the root is a leaf, just delete it and we're done
      @root = nil
    else
      # Find parent of node to be deleted and set relevant child node to nil
      parent_node = s_find(parent(node.value))
      parent_node.left = nil if parent_node.left == node
      parent_node.right = nil if parent_node.right == node
    end
    node.value
  end

  def delete_with_child(node)
    value = node.value
    # Note: If this method is called, it definitely has at least one child node
    # We'll find the previous or succesor node as our replacement
    replacement = node.right.nil? ? previous(value) : successor(value)
    # We need to recursively delete that replacement to avoid duplication
    delete(replacement)
    # Now we can reassign our node to the value of the replacement
    node.value = replacement
    value
  end

  def mirror?(left, right)
    return right.nil? if left.nil?
    return false if right.nil?

    mirror?(left.left, right.right) && mirror?(left.right, right.left)
  end

  def balance_insert(values)
    midpoint = values.length / 2
    new_node = Node.new(values[midpoint])

    first_half = values[0...midpoint]
    second_half = values[midpoint + 1..]

    new_node.left = balance_insert(first_half) unless first_half.nil? || first_half.empty?
    new_node.right = balance_insert(second_half) unless second_half.nil? || second_half.empty?

    new_node
  end
end

# OLD CODE

# def full?
#   # If this node has no children, return true
#   return true if @left.nil? && @right.nil?

#   # If this node has two children, we need to check for problems further down
#   # Note that this will only return true if both subtrees full
#   return @left.full? && @right.full? unless @left.nil? || @right.nil?

#   # Else this node has only one child so clearly false
#   false
# end

# def height
#   return 1 if @left.nil? && @right.nil?

#   return [@left.height, @right.height].max + 1 unless @left.nil? || @right.nil?

#   @left.nil? ? @right.height + 1 : @left.height + 1
# end

# def build_array(node, array)
#   # If there's a left subtree, add all that to our array
#   array = build_array(node.left, array) unless node.left.nil?

#   # Push this node's value into the array
#   array << node.value
#   # If there's no right subtree, we're done
#   # Else return the value of calling #build_array on that
#   node.right.nil? ? array : build_array(node.right, array)
# end

# def build_pre(node, array)
#   array << node.value
#   array = build_pre(node.left, array) unless node.left.nil?
#   node.right.nil? ? array : build_pre(node.right, array)
# end

# def build_post(node, array)
#   array = build_post(node.left, array) unless node.left.nil?
#   node.right.nil? ? array : build_post(node.right, array)
#   array << node.value
# end
