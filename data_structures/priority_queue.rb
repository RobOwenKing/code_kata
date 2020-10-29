# Priority Queue class with some basic operations
class PriorityQueue
  def initialize
    # I'll use an array to store the elements
    @queue = []
  end

  def enqueue(val, priority)
    # Enter elements ordered by priority so #dequeue is O(1)
    # Find the position of the first element with a higher priority
    pos = @queue.bsearch_index { |element| element[1] > priority }
    # If there's such an element, add the new value before it
    # pos can be nil for an empty list or if it's highest priority
    # In both cases, adding the new value to the end works
    pos.nil? ? @queue.push([val, priority]) : @queue.insert(pos, [val, priority])
  end

  def dequeue
    # Return the value of the last element, else nil
    @queue.empty? ? nil : @queue.pop[0]
  end

  # A #peek method
  def next
    @queue.empty? ? nil : @queue[-1][0]
  end

  # Not worrying about uniqueness
  def find_priority(value)
    # Find an item in the queue whose first element matches given value
    found = @queue.bsearch { |item| item[0] == value }
    # If there is one, return its priority, else return nil
    found.nil? ? nil : found[1]
  end

  # Again, not worrying about uniqueness
  def position(value)
    # Find the index of some element with given value
    index = @queue.find_index { |item| item[0] == value }
    # Return its position from the **end**
    index.nil? ? nil : @queue.length - index
  end

  # Still not worrying about uniqueness
  def change_priority(value, priority)
    # Plain #delete would delete any that match value
    index = @queue.find_index { |item| item[0] == value }
    @queue.delete_at(index) unless index.nil?

    enqueue(value, priority)
  end
end
