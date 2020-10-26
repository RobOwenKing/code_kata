class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  attr_reader :root

  def initialize(value)
    @root = Node.new(value)
    @count = 0
  end
end
