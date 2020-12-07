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
    # If the parent's value is smaller than the child, do nothing
    return unless @heap[parent] > @heap[index]

    # Else, swap the child with its parent
    swap(index, parent)
    # Then iterate #bubble_up
    bubble_up(parent) unless parent.zero?
  end

  # Input: Integer, the index of an element in @heap
  def min_child_index(index)
    left_child_index = left_child_index(index)
    # Return nil if it has no left child
    return nil if left_child_index.nil?

    right_child_index = right_child_index(index)
    # If it has only a left child, return that
    return left_child_index if right_child_index.nil?

    # If it has two children, return the index of the child with smaller value
    @heap[left_child_index] < @heap[right_child_index] ? left_child_index : right_child_index
  end

  # Input: Integer, the index of the element to start with
  def bubble_down(index)
    # We first need the index of the lesser of its two children
    min_child_index = min_child_index(index)
    # If it has no children, do nothing
    return if min_child_index.nil?

    # If it is less than its min child, do nothing
    current = @heap[index]
    min_child = @heap[min_child_index]
    return unless current > min_child

    # Otherwise, we need to swap the element with its smaller child
    swap(index, min_child_index)
    # Then iterate #bubble_down
    bubble_down(min_child_index)
  end
end
