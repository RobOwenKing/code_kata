FULL = {
  both: proc { true },
  neither: proc { |left, right| left.iterate(FULL) && right.iterate(FULL) },
  left: proc { false },
  right: proc { false }
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

  def height
    return 1 if @left.nil? && @right.nil?

    return [@left.height, @right.height].max + 1 unless @left.nil? || @right.nil?

    @left.nil? ? @right.height + 1 : @left.height + 1
  end

  def iterate(methods)
    return methods[:both].call if @left.nil? && @right.nil?

    return methods[:neither].call(@left, @right) unless @left.nil? || @right.nil?

    @left.nil? ? methods[:right].call : methods[:left].call
  end
end

# Binary Search Tree class itself
class BinarySearchTree
  attr_reader :root, :count

  def initialize(value = nil)
    @root = value.nil? ? nil : Node.new(value)
    @count = @root.nil? ? 0 : 1
  end

  def insert(value)
    # Find where the given value would go in the tree
    parent_node = @root.nil? ? nil : @root.find_node(value)
    # If that would repeat a value, return nil
    return nil if !parent_node.nil? && parent_node.value == value

    # Else, we're adding a node, so update the count and create it
    @count += 1
    new_node = Node.new(value)
    # If no root, put the new node there
    return @root = new_node if @root.nil?

    # Else place the node in the relevant child position
    value < parent_node.value ? parent_node.left = new_node : parent_node.right = new_node
  end

  def include?(value)
    return false if @root.nil?

    found_node = @root.find_node(value)
    found_node.value == value
  end

  def min
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.left until current_node.left.nil?
    current_node.value
  end

  def max
    return nil if @root.nil?

    current_node = @root
    current_node = current_node.right until current_node.right.nil?
    current_node.value
  end

  def find(value)
    found_node = root.find_node(value)
    found_node.value == value ? found_node : nil
  end

  def floor(value)
    # We're going to use a private method which also takes a node as input
    # This allows us to use recursion
    # We evaluate here to avoid bringing nil into comparisons in #find_floor
    best_find = find_floor(value, root)
    best_find > value ? nil : best_find
  end

  def ceil(value)
    # Based on #floor
    best_find = find_ceil(value, root)
    best_find < value ? nil : best_find
  end

  # Returns an array of the tree's elements in sorted order
  # (In lieu of a print method)
  def to_a
    root.nil? ? [] : build_array(root, [])
  end

  def height
    @root.nil? ? 0 : @root.height
  end

  def level(value)
    current_node = @root
    tracker = 1

    until current_node.nil? || current_node.value == value
      tracker += 1
      current_node = current_node.value < value ? current_node.right : current_node.left
    end

    current_node.nil? ? nil : tracker
  end

  # In a full tree, every node has either 0 or 2 children
  def full?
    # Define as true if tree empty, else start iterating
    # @root.nil? ? true : @root.full?
    @root.nil? ? true : @root.iterate(FULL)
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

  def build_array(node, array)
    # If there's a left subtree, add all that to our array
    array = build_array(node.left, array) unless node.left.nil?

    # Push this node's value into the array
    array << node.value
    # If there's no right subtree, we're done
    # Else return the value of calling #build_array on that
    node.right.nil? ? array : build_array(node.right, array)
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
