# I want to implement the most generic linked list possible
# As such, it will be singly-linked and only keep track of the head
# In a real-life application, keeping track of size/tail might well pay off

# Contents
# class Node
# - #initialize
# class LinkedList
# - Open Methods
# - - #initialize
# - - #first
# - - #tail
# - - #last
# - - #unshift(value)
# - - #shift
# - - #push(value)
# - - #pop
# - - #length


# Used for #reverse
require_relative 'stack'

# Node class for items of our linked list
class Node
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    if !next_node.nil? && next_node.class != Node
      raise ArgumentError, 'next_node must be a Node or nil'
    end

    @value = value
    @next = next_node
  end
end

# The linked list class itself
class LinkedList
  attr_accessor :head

  def initialize(value = nil)
    # List can start empty or with one node
    @head = value.nil? ? nil : Node.new(value)
  end

  # Return the value of the head, #head returns the node
  def first
    @head.value
  end

  # Returns the last node, #last returns its value
  def tail
    return nil if @head.nil?
    # A list with a loop in has no tail
    return nil if loops?

    # Step through nodes until next is nil (which tests to false)
    current_node = @head
    current_node = current_node.next while current_node.next
    current_node
  end

  # Return the value of the tail, #tail returns the node
  def last
    tail.nil? ? nil : tail.value
  end

  # Add a new value to the start of the list
  def unshift(value)
    current_head = @head
    # Create a new head for the list with the given value pointing to existing head
    @head = Node.new(value, current_head)
  end

  # Remove the head of the list and return its value
  def shift
    return nil if head.nil?

    # If there's a head, set the list's head to its #next and return its value
    current_head = @head
    @head = current_head.next
    current_head.value
  end

  # Add a new value to the end of the list
  def push(value)
    # Can't append to a list that loops
    return nil if loops?

    # If there's no head, pushing will create a head
    # Else, it will give the list a new tail
    @head.nil? ? @head = Node.new(value) : tail.next = Node.new(value)
  end

  # Remove the list's tail and return its value
  def pop
    return nil if tail.nil?

    current_tail = tail
    fetch_node(length - 2).next = nil
    current_tail.value
  end

  # Return the number of nodes in the list
  # Will have issues if the list loops
  def length
    count = 0
    current_node = @head
    # Count through nodes until next is nil (which tests to false)
    while current_node
      count += 1
      current_node = current_node.next
    end
    count
  end

  # Returns the node at the given index
  def fetch_node(index)
    # Return nil if there's no such index
    return nil if index > length - 1
    # Handle negative indexes
    return fetch(length + index) if index.negative?

    # Step through nodes until we reach the given index
    current_node = head
    until index.zero?
      index -= 1
      current_node = current_node.next
    end
    current_node
  end

  # Returns the value of the node at the given index
  def fetch(index)
    # Return nil if there's no such index
    return nil if index > length - 1
    # Handle negative indexes
    return fetch(length + index) if index.negative?

    fetch_node(index).value
  end

  def find_index(value)
    # Find the index of the first node with the given value
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
    # Like #find_index, but return the node, not its index
    return nil if head.nil?

    current_node = head
    while current_node
      return current_node if current_node.value == value

      current_node = current_node.next
    end
    nil
  end

  def insert(index, value)
    # Create a node with given value at the given index
    # Handle negative indexes
    return insert(length + index, value) if index.negative?
    # If index is 0, equivalent to adding a new head
    return unshift(value) if index.zero?
    # If the index is the current tail's + 1, make a new tail
    return push(value) if index == length
    return nil if index > length

    prev_node = fetch_node(index - 1)
    # Create a new node linked to the one it's replacing
    new_node = Node.new(value, prev_node.next)
    # Update the link in the previous node to our new node
    prev_node.next = new_node
  end

  def delete_at(index)
    # Delete the node at the given index and return its value
    return nil if index > length - 1
    return delete_at(length + index) if index.negative?

    prev_node = fetch_node(index - 1)
    to_delete = prev_node.next
    prev_node.next = to_delete.next
    to_delete.value
  end

  def loops?
    # Guard clause needed for loop to not give false positive
    return false if @head.nil? || @head.next.nil?

    # Floyd's algorithm
    tortoise = @head
    hare = @head

    # One pointer moves in steps of one, one in steps of two
    # If they're ever the same, there must be a loop
    until hare.nil?
      tortoise = tortoise.next
      hare = hare.next.nil? ? nil : hare.next.next

      return true if hare == tortoise
    end
    # Out here, hare must have reached the tail without finding a loop
    false
  end

  def reverse
    new_list = LinkedList.new
    current_node = @head
    # For each node of original list, unshift it to head of new list
    until current_node.nil?
      new_list.unshift(current_node.value)
      current_node = current_node.next
    end

    new_list
  end

  def reverse!
    # Could just use reverse and reassign @head
    # But let's do something different
    return @head if @head.next.nil?

    prev_node = nil
    current_node = @head

    until current_node.nil?
      next_node = current_node.next
      current_node.next = prev_node
      prev_node = current_node
      current_node = next_node
    end

    @head = prev_node
  end
end
