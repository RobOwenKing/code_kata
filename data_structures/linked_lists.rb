# I want to implement the most generic linked list possible
# As such, it will be singly-linked and only keep track of the head

class Node
  # Needed for tests
  attr_reader :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node

    return unless !@next.nil? && @next.class != Node

    raise ArgumentError, 'next_node must be a Node or nil'
  end
end

class LinkedList
  attr_reader :head

  def initialize(value = nil)
    @head = value.nil? ? nil : Node.new(value)
  end

  # Mirroring inbuilt Ruby data types, #first should alias #head
  def first
    @head
  end
end
