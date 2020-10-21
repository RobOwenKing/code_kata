require 'rspec'
require_relative 'queue'

RSpec.describe MyQueue do
  describe '#enqueue and #dequeue' do
    queue = MyQueue.new
    it 'Returns nil for empty queue' do
      expect(queue.dequeue).to eql(nil)
    end
    it 'Dequeues correct value after one enqueue' do
      queue.enqueue(10)
      expect(queue.dequeue).to eql(10)
    end
    it 'Dequeues correct value after two enqueues' do
      queue.enqueue(20)
      queue.enqueue(30)
      expect(queue.dequeue).to eql(20)
    end
    it 'Dequeues correct value second time' do
      # Queue still contains 30 from previous test
      queue.enqueue(40)
      queue.enqueue(50)
      queue.dequeue
      expect(queue.dequeue).to eql(40)
    end
  end
end
