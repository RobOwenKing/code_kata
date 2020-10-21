# Queue implemented using two stacks
# Inspired by InterviewNest (https://www.youtube.com/watch?v=esuEG9VINVA)

require_relative 'stack'

class MyQueue
  def initialize
    @for_enqueue = Stack.new
    @for_dequeue = Stack.new
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
