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
    # Either return nil or the value of the last element
    @queue.empty? ? nil : @queue.pop[0]
  end

  # A #peek method
  def next
    @queue.empty? ? nil : @queue[-1][0]
  end
end
