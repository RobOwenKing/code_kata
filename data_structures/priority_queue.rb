# Priority Queue class with some basic operations

class PriorityQueue
  def initialize
    @queue = []
  end

  def enqueue(val, priority)
    pos = @queue.bsearch_index { |element| element[1] > priority }
    pos.nil? ? @queue.push([val, priority]) : @queue.insert(pos, [val, priority])
  end

  def dequeue
    @queue.empty? ? nil : @queue.pop[0]
  end
end
