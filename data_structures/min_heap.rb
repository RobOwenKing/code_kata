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

  # Input: Object
  # Adds the given object to the end of @heap, then bubbles if necessary to preserve heapness
  def insert(value)
    @heap << value

    bubble_up(@heap.length - 1) unless @heap.length < 2
  end

  # Input: Object
  # Deletes the first element found in the heap matching the given object
  def delete(value)
    # Find the element to delete
    index = index(value)
    not_final = index < @heap.length - 1
    # Unless it's the final leaf, replace the value to be deleted with the final leaf
    @heap[index] = @heap[-1] if not_final
    # Delete the final leaf (either what we want to delete, or a duplicate now)
    @heap.pop
    # If necessary, bubble down
    bubble_down(index) if not_final
  end

  private

  # Input: Object
  # Returns the index in @heap of the first element whose value matches the object passed
  def index(value)
    @heap.index(value)
  end

  # Input: Integer, the index of a child in @heap
  # Output: Integer, the index of that child's parent in @heap
  def parent_index(child_index)
    # We don't need to call floor because of how Ruby handles division of integers
    (child_index - 1) / 2
  end

  def left_child_index(parent_index)
    option = (parent_index * 2) + 1

    option < @heap.length ? option : nil
  end

  def right_child_index(parent_index)
    option = (parent_index * 2) + 2

    option < @heap.length ? option : nil
  end

  # Input: (Integer, Integer), indexes of elements in @heap
  # Swaps the values in the heap at the two given indexes
  def swap(index1, index2)
    hold = @heap[index1]
    @heap[index1] = @heap[index2]
    @heap[index2] = hold
  end

  # Input: Integer, index of an element in @heap
  # Swaps that element with its parent if it is smaller than its parent
  # If a swap has taken place, recursively bubble
  def bubble_up(index)
    parent = parent_index(index)
    return unless @heap[parent] > @heap[index]

    swap(index, parent)
    bubble_up(parent) unless parent.zero?
  end

  def min_child_index(index)
    left_child_index = left_child_index(index)
    return nil if left_child_index.nil?

    right_child_index = right_child_index(index)
    return left_child_index if right_child_index.nil?

    @heap[left_child_index] < @heap[right_child_index] ? left_child_index : right_child_index
  end

  def bubble_down(index)
    min_child_index = min_child_index(index)
    return if min_child_index.nil?

    current = @heap[index]
    min_child = @heap[min_child_index]
    return unless current > min_child

    swap(index, min_child_index)
    bubble_down(min_child_index)
  end
end
