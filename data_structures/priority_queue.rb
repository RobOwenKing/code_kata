# Priority Queue class with some basic operations

class PriorityQueue
  def initialize
    @queue = []
  end

  def enqueue(val)
    @for_enqueue.push(val)
  end

  def dequeue
    if @for_dequeue.empty?
      @for_dequeue.push(@for_enqueue.pop) until @for_enqueue.empty?
    end

    @for_dequeue.pop
  end
end
