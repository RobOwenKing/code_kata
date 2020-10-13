# I want to implement the most generic linked list possible
# As such, it will be singly-linked and only keep track of the head

# Node class for items of our linked list
class Node
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node

    return unless !@next.nil? && @next.class != Node

    raise ArgumentError, 'next_node must be a Node or nil'
  end
end

# The linked list class itself
class LinkedList
  attr_accessor :head

  def initialize(value = nil)
    @head = value.nil? ? nil : Node.new(value)
  end

  def first
    @head.value
  end

  def tail
    return nil if @head.nil?

    current_node = @head
    current_node = current_node.next until current_node.next.nil?
    current_node
  end

  def last
    tail.value
  end

  def unshift(value)
    current_head = @head
    @head = Node.new(value, current_head)
  end

  def shift
    return nil if head.nil?

    current_head = @head
    @head = current_head.next
    current_head.value
  end

  def push(value)
    @head.nil? ? @head = Node.new(value) : tail.next = Node.new(value)
  end

  def pop
    return nil if tail.nil?

    current_tail = tail
    current_node = @head
    current_node = current_node.next until current_node.next == current_tail
    current_node.next = nil
    current_tail.value
  end

  def length
    count = 0
    current_node = @head
    until current_node.nil?
      count += 1
      current_node = current_node.next
    end
    count
  end

  def fetch(index)
    return nil if index > length - 1
    return fetch(length + index) if index.negative?

    current_node = head
    until index.zero?
      index -= 1
      current_node = current_node.next
    end
    current_node.value
  end
end
