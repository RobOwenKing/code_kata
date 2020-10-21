# Queue implemented using two stacks
# Inspired by InterviewNest (https://www.youtube.com/watch?v=esuEG9VINVA)

require_relative 'stack'

class Queue
  def initialize
    @for_enqueue = Stack.new
    @for_dequeue = Stack.new
  end

  def dequeue
    @for_dequeue.pop
  end
end
