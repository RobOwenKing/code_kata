# frozen_string_literal: true

require 'rspec'
require_relative 'queue'

RSpec.describe MyQueue do
  describe '#enqueue and #dequeue' do
    my_queue = MyQueue.new
    ruby_queue = Queue.new
    it 'Returns nil for empty queue' do
      expect(my_queue.dequeue).to eql(nil)
    end
    it 'Dequeues correct value after one enqueue' do
      my_queue.enqueue(10)
      ruby_queue.enq(10)
      expect(my_queue.dequeue).to eql(ruby_queue.deq)
    end
    it 'Dequeues correct value after two enqueues' do
      my_queue.enqueue(20)
      ruby_queue.enq(20)
      my_queue.enqueue(30)
      ruby_queue.enq(30)
      expect(my_queue.dequeue).to eql(ruby_queue.deq)
    end
    it 'Dequeues correct value second time' do
      # Queue still contains 30 from previous test
      my_queue.enqueue(40)
      ruby_queue.enq(40)
      my_queue.enqueue(50)
      ruby_queue.enq(50)
      my_queue.dequeue
      ruby_queue.deq
      expect(my_queue.dequeue).to eql(ruby_queue.deq)
    end
  end
end
