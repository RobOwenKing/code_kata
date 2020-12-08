# Node class for our Binary Tree
# Methods with the prefix s are for Search Trees
class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def sfind_node(value)
    return self if value == @value

    if value < @value
      # If the value we're looking for is less than this node's value
      # If it has no left child, return itself, otherwise go recursive
      @left.nil? ? self : @left.sfind_node(value)
    else
      # Same thing for larger values
      @right.nil? ? self : @right.sfind_node(value)
    end
  end

  def sfind_parent(value)
    if value < @value
      return false if @left.nil?
      return self if @left.value == value

      @left.sfind_parent(value)
    else
      return false if @right.nil?
      return self if @right.value == value

      @right.sfind_parent(value)
    end
  end

  # Input: A Hash of Procs to be called on the node depending on how many of its children are nil
  def iterate(methods)
    # Call Proc :both when both children are nil
    return methods[:both].call if @left.nil? && @right.nil?
    # Call Proc :neither when neither child is nil
    return methods[:neither].call(@left, @right) unless @left.nil? || @right.nil?

    # When here precisely one child will be nil
    # We call :left when the left child is nil, else :right
    @left.nil? ? methods[:left].call(@left, @right) : methods[:right].call(@left, @right)
  end

  # This is a helper method for BinaryTree#invert
  # It swaps the left and right children of the node it's called on
  # Returns: Node
  def swap
    holding = @left.nil? ? nil : @left.swap
    @left = @right.nil? ? nil : @right.swap
    @right = holding

    # We need to return self for the assignment of holding and @left above to work
    self
  end
end
