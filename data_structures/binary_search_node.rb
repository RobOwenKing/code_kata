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

  def swap
    holding = @left.nil? ? nil : @left.swap
    @left = @right.nil? ? nil : @right.swap
    @right = holding

    self
  end
end
