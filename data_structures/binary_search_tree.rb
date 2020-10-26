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
      return @left.nil? ? self : @left.find_node(value)
    end
  end
end

class BinarySearchTree
  attr_reader :root

  def initialize(value)
    @root = Node.new(value)
    @count = 0
  end

  def insert(value)
    new_node = Node.new(value)
    parent_node = @root.find_node(value)

    return nil if parent_node.value == value

    value < parent_node.value ? parent_node.left = new_node : parent_node.right = new_node
  end
end
