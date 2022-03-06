# frozen_string_literal: true

# Data structures practice, first exercise
# Ruby port of Traversy Media JS example (https://www.youtube.com/watch?v=wtynhUwS5hI)

# Stack class, to initialize with no arguments
class Stack
  def initialize
    @stack = []
    @count = 0
  end

  def empty?
    @count.zero?
  end

  def push(element)
    @stack[@count] = element
    @count += 1
    @count - 1
  end

  def pop
    return nil if empty?

    @count -= 1
    # Different to the video
    # There, the element is left in the array, overwritten by later pushes
    @stack.delete_at(@count)
  end

  def peek
    empty? ? nil : @stack[@count - 1]
  end

  def size
    @count
  end

  def clear
    @stack = []
    @count = 0
  end
end
