require 'rspec'
require_relative 'priority_queue'

RSpec.describe PriorityQueue do
  describe '#enqueue and #dequeue' do
    priority_queue = PriorityQueue.new
    it 'Returns nil for empty queue' do
      expect(priority_queue.dequeue).to eql(nil)
    end
    it 'Dequeues correct value after one enqueue' do
      priority_queue.enqueue('Hello World', 1)
      expect(priority_queue.dequeue).to eql('Hello World')
    end
    it 'Dequeues correct value after two enqueues, highest priority last' do
      priority_queue.enqueue('Tweedledum', 2)
      priority_queue.enqueue('Tweedledee', 3)
      expect(priority_queue.dequeue).to eql('Tweedledee')
    end
    it 'Dequeues correct value after two enqueues, highest priority first' do
      priority_queue.enqueue('Tweedledum', 5)
      priority_queue.enqueue('Tweedledee', 4)
      expect(priority_queue.dequeue).to eql('Tweedledum')
    end
    it 'Dequeues correct value second time' do
      priority_queue.enqueue('one', 11)
      priority_queue.enqueue('two', 12)
      priority_queue.dequeue
      expect(priority_queue.dequeue).to eql('one')
    end
  end
end
