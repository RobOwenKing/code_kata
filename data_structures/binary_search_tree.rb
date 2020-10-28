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
      return @left.nil? ? self : @left.find_node(value)
    else
      # Same thing for larger values
      return @right.nil? ? self : @right.find_node(value)
    end
  end
end

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
    find_floor(value, root)
  end

  private

  def find_floor(value, node)
    return value if node.value == value

    if node.value > value
      return node.left.nil? ? node.value : find_floor(value, node.left)
    else
      return node.right.nil? ? node.value : find_floor(value, node.right)
    end
  end
end
