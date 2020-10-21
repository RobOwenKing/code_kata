require 'rspec'
require_relative 'queue'

RSpec.describe Queue do
  describe '#enque and #deque' do
    queue = Queue.new
    it 'Returns nil for empty queue' do
      expect(queue.deque).to eql(nil)
    end
    it 'Returns the correct value after one round' do
      queue.enque(10)
      expect(queue.deque).to eql(10)
    end
    it 'Returns the correct value after two rounds' do
      queue.enque(20)
      queue.enque(30)
      expect(queue.deque).to eql(30)
    end
    it 'Returns the correct value second time' do
      queue.enque(40)
      queue.enque(50)
      queue.deque
      expect(queue.deque).to eql(40)
    end
  end
end
