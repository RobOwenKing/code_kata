# Data structures practice, first exercise
# Ruby port of Javascript example here: https://www.youtube.com/watch?v=wtynhUwS5hI

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
    return nil if @stack.empty?

    @count -= 1
    @stack[@count]
  end
end
