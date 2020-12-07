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

  # Input: Integer
  # Adds the element to the end of @heap, then bubbles if necessary to preserve heapness
  def insert(value)
    @heap << value

    current = @heap.length - 1
    parent = parent_index(current)

    while !current.zero? && @heap[parent] > @heap[current]
      swap(current, parent)
      current = parent
      parent = parent_index(current)
    end
  end

  private

  # Input: Integer, the index of a child in @heap
  # Output: Integer, the index of that child's parent in @heap
  def parent_index(child_index)
    # We don't need to call floor because of how Ruby handles division of integers
    (child_index - 1) / 2
  end

  # Input: (Integer, Integer), indexes of elements in @heap
  # Swaps the values in the heap at the two given indexes
  def swap(index1, index2)
    hold = @heap[index1]
    @heap[index1] = @heap[index2]
    @heap[index2] = hold
  end
end
