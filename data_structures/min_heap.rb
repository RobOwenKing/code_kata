class MinHeap
  def initialize
    @heap = []
  end

  def to_a
    @heap
  end

  def root
    @heap[0]
  end

  def insert(value)
    @heap << value
  end
end
