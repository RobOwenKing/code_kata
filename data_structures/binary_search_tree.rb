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
  end
end
