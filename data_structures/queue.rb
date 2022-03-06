# frozen_string_literal: true

require_relative 'stack'

# Queue implemented using two stacks
# Inspired by InterviewNest (https://www.youtube.com/watch?v=esuEG9VINVA)
class MyQueue
  def initialize
    # One queue will receive new entries
    @for_enqueue = Stack.new
    # Another will be used to reverse the order for dequeuing
    @for_dequeue = Stack.new
  end

  def enqueue(val)
    @for_enqueue.push(val)
  end

  def dequeue
    # If there is nothing in the second queue
    if @for_dequeue.empty?
      # Empty the first queue into it, reversing the order automatically
      # That means popping from the second queue will now be oldest entry
      @for_dequeue.push(@for_enqueue.pop) until @for_enqueue.empty?
    end

    @for_dequeue.pop
  end

  def empty?
    @for_enqueue.empty? && @for_dequeue.empty?
  end
end
