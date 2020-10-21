require 'rspec'
require_relative 'queue'

RSpec.describe Queue do
  describe '#enqueue and #dequeue' do
    queue = Queue.new
    it 'Returns nil for empty queue' do
      expect(queue.dequeue).to eql(nil)
    end
    it 'Returns the correct value after one round' do
      queue.enqueue(10)
      expect(queue.dequeue).to eql(10)
    end
    it 'Returns the correct value after two rounds' do
      queue.enqueue(20)
      queue.enqueue(30)
      expect(queue.dequeue).to eql(30)
    end
    it 'Returns the correct value second time' do
      queue.enqueue(40)
      queue.enqueue(50)
      queue.dequeue
      expect(queue.dequeue).to eql(40)
    end
  end
end
