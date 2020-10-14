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
    # List can start empty or with one node
    @head = value.nil? ? nil : Node.new(value)
  end

  def first
    # Return the value of the head, #head returns the node
    @head.value
  end

  def tail
    return nil if @head.nil?
    # A list with a loop in has no tail
    return nil if loops?

    # Step through nodes until next is nil (which tests to false)
    current_node = @head
    current_node = current_node.next while current_node.next
    current_node
  end

  def last
    # Return the value of the tail, #tail returns the node
    tail.nil? ? nil : tail.value
  end

  def unshift(value)
    # Create a new head for the list with the given value
    current_head = @head
    @head = Node.new(value, current_head)
  end

  def shift
    return nil if head.nil?

    # If there's a head, delete it and returns its value
    current_head = @head
    @head = current_head.next
    current_head.value
  end

  def push(value)
    # Can't append to a list that loops
    return nil if loops?

    # If there's no head, pushing will create a head
    # Else, it will give the list a new tail
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
    # Will have issues if list loops

    count = 0
    current_node = @head
    while current_node
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

  def fetch_node(index)
    current_node = head
    until index.zero?
      index -= 1
      current_node = current_node.next
    end
    current_node
  end

  def find_index(value)
    return nil if head.nil?

    current_node = head
    count = 0
    while current_node
      return count if current_node.value == value

      current_node = current_node.next
      count += 1
    end
    nil
  end

  def find_node(value)
    return nil if head.nil?

    current_node = head
    while current_node
      return current_node if current_node.value == value

      current_node = current_node.next
    end
    nil
  end

  def insert(index, value)
    return nil if index > length - 1
    return insert(length + index, value) if index.negative?
    return unshift(value) if index.zero?

    prev_node = fetch_node(index - 1)
    new_node = Node.new(value, prev_node.next)
    prev_node.next = new_node
  end

  def delete_at(index)
    return nil if index > length - 1
    return delete_at(length + index) if index.negative?

    prev_node = fetch_node(index - 1)
    to_delete = prev_node.next
    prev_node.next = to_delete.next
    to_delete.value
  end

  def loops?
    return false if @head.nil? || @head.next.nil?

    # Floyd's algorithm
    tortoise = @head
    hare = @head

    until hare.nil?
      tortoise = tortoise.next
      hare = hare.next.nil? ? nil : hare.next.next

      return true if hare == tortoise
    end
    false
  end
end
