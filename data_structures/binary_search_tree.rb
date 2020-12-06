# We'll use a queue for the breadth-first ordering
require_relative 'queue'

FULL = {
  both: proc { true },
  neither: proc { |left, right| left.iterate(FULL) && right.iterate(FULL) },
  left: proc { false },
  right: proc { false }
}

DEGENERATE = {
  both: proc { true },
  neither: proc { false },
  left: proc { |_left, right| right.iterate(DEGENERATE) },
  right: proc { |left, _right| left.iterate(DEGENERATE) }
}

HEIGHT = {
  both: proc { 1 },
  neither: proc { |left, right| [left.iterate(HEIGHT), right.iterate(HEIGHT)].max + 1 },
  left: proc { |_left, right| right.iterate(HEIGHT) + 1 },
  right: proc { |left, _right| left.iterate(HEIGHT) + 1 }
}

BALANCED = {
  both: proc { true },
  neither: proc do |left, right|
    left.iterate(BALANCED) && right.iterate(BALANCED) && (left.iterate(HEIGHT) - right.iterate(HEIGHT)).abs <= 1
  end,
  left: proc { |_left, right| right.left.nil? && right.right.nil? },
  right: proc { |left, _right| left.left.nil? && left.right.nil? }
}

# Node class for our Binary Search Tree
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def find_node(value)
    return self if value == @value

    if value < @value
      # If the value we're looking for is less than this node's value
      # If it has no left child, return itself, otherwise go recursive
      @left.nil? ? self : @left.find_node(value)
    else
      # Same thing for larger values
      @right.nil? ? self : @right.find_node(value)
    end
  end

  def find_parent(value)
    if value < @value
      return false if @left.nil?
      return self if @left.value == value

      @left.find_parent(value)
    else
      return false if @right.nil?
      return self if @right.value == value

      @right.find_parent(value)
    end
  end

  def iterate(methods)
    return methods[:both].call if @left.nil? && @right.nil?

    return methods[:neither].call(@left, @right) unless @left.nil? || @right.nil?

    @left.nil? ? methods[:left].call(@left, @right) : methods[:right].call(@left, @right)
  end
end

# Binary Search Tree class itself
class BinarySearchTree
  attr_accessor :root

  def initialize(value = nil)
    @root = value.nil? ? nil : Node.new(value)
  end

  # Add a value to the tree
  # Returns new Node
  # Repeat values not added, return nil
  def insert(value)
    # Find where the given value would go in the tree
    parent_node = @root.nil? ? nil : @root.find_node(value)
    # If that would repeat a value, return nil
    return nil if !parent_node.nil? && parent_node.value == value

    # Else, we're adding a node
    new_node = Node.new(value)
    # If no root, put the new node there
    return @root = new_node if @root.nil?

    # Else place the node in the relevant child position
    value < parent_node.value ? parent_node.left = new_node : parent_node.right = new_node
  end

  # Test whether a given value is in the tree
  # Returns boolean
  def include?(value)
    return false if @root.nil?

    found_node = @root.find_node(value)
    found_node.value == value
  end

  # Return the minimum value of any node in the tree
  # Returns nil for an empty tree
  def min
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.left until current_node.left.nil?
    current_node.value
  end

  # Return the maximum value of any node in the tree
  # Returns nil for an empty tree
  def max
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.right until current_node.right.nil?
    current_node.value
  end

  # Returns the node from the tree with the given value
  # Returns nil if no such node in the tree
  def find(value)
    found_node = @root.find_node(value)
    found_node.value == value ? found_node : nil
  end

  # Returns the value of the parent node of the node with the passed value
  # Returns nil if the value matches the root
  # Returns false if there is no node with the given value
  def parent(value)
    return nil if @root.value == value

    found_node = @root.find_parent(value)
    !found_node ? false : found_node.value
  end

  # Deletes node with given value and returns that value
  # If no such node, returns nil
  # The algorithm maintains tree connectedness and sortedness
  def delete(value)
    node = find(value)
    return nil if node.nil?

    if node.left.nil? && node.right.nil?
      delete_leaf(node)
    else
      delete_with_child(node)
    end
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

  # Returns a sorted array of the values of the tree's nodes
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

  # Returns a sorted array of the values of the tree's leaves
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

  # Returns the number of nodes in the tree (integer)
  def count
    # Quick fix
    # Would be better to count while traversing rather than building array then counting that
    to_a.count
  end

  # Returns a new Binary Search Tree
  # New tree's root node is the node of original tree with passed value
  def subtree(value)
    node = find(value)
    if node.nil?
      nil
    else
      tree = BinarySearchTree.new
      tree.root = node
      tree
    end
  end

  # Returns the next value in the tree larger than the passed value
  # Returns nil if no larger value found
  # Returns false if no node found with the passed value
  def successor(value)
    node = find(value)
    return false if node.nil?

    # If the node has a right subtree, its minimum value will be next largest
    return subtree(node.right.value).min unless node.right.nil?

    current_parent = parent(node.value)
    until find(current_parent).left.value == node.value
      node = find(current_parent)
      current_parent = parent(node.value)
      return nil if current_parent.nil?
    end
    current_parent
  end

  # Returns the next value in the tree smaller than the passed value
  # Returns nil if no smaller value found
  # Returns false if no node found with the passed value
  def previous(value)
    node = find(value)
    return false if node.nil?

    # If the node has a left subtree, its maximum value will be next smallest
    return subtree(node.left.value).max unless node.left.nil?

    current_parent = parent(node.value)
    until find(current_parent).right.value == node.value
      node = find(current_parent)
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

    queue = MyQueue.new
    current = @root

    until current.nil?
      queue.enqueue(current.left)
      queue.enqueue(current.right)
      current = queue.dequeue
    end

    return false unless queue.dequeue.nil? until queue.empty?

    true
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
      parent_node = find(parent(node.value))
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
