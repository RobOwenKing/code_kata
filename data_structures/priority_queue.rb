# A Priority Queue class in Ruby with some basic operations
# Contents
# - class PriorityQueue
# - - #initialize
# - - #enqueue(val, priority)
# - - #dequeue
# - - #next
# - - #find_priority(value)
# - - #position(value)
# - - #change_priority(value, priority)

class PriorityQueue
  def initialize
    # I'll use an array to store the elements
    # Each entry will itself be an array [val, priority]
    @queue = []
  end

  # Add the given value to our queue with given priority
  def enqueue(val, priority)
    # Enter elements ordered by priority so #dequeue is O(1)
    # Find the position of the first element with a higher priority
    pos = @queue.bsearch_index { |element| element[1] > priority }
    # If there's such an element, add the new value before it
    # pos can be nil for an empty list or if it's highest priority
    # In both cases, adding the new value to the end works
    pos.nil? ? @queue.push([val, priority]) : @queue.insert(pos, [val, priority])
  end

  # Delete the highest priority element and returns its value
  def dequeue
    # Return the value (first element) of the last element of the queue, else nil
    @queue.empty? ? nil : @queue.pop[0]
  end

  # A #peek method
  # Returns the value of the next element without deleting it
  def next
    @queue.empty? ? nil : @queue[-1][0]
  end

  # Find the priority associated with the given value
  # Not worrying about uniqueness
  def find_priority(value)
    # Find an item in the queue whose first element matches given value
    found = @queue.bsearch { |item| item[0] == value }
    # If there is one, return its priority, else return nil
    found.nil? ? nil : found[1]
  end

  # Return a value's position in the queue (highest priority value returns 1)
  # Again, not worrying about uniqueness
  def position(value)
    # Find the index of some element with given value
    index = @queue.find_index { |item| item[0] == value }
    # Return its position from the **end**
    index.nil? ? nil : @queue.length - index
  end

  # Still not worrying about uniqueness
  # We fake this by deleting the old element and creating a new one
  def change_priority(value, priority)
    # Plain #delete would delete any that match value
    index = @queue.find_index { |item| item[0] == value }
    @queue.delete_at(index) unless index.nil?

    enqueue(value, priority)
  end
end
