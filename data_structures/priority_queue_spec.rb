# frozen_string_literal: true

require 'rspec'
require_relative 'priority_queue'

RSpec.describe PriorityQueue do
  describe '#enqueue and #dequeue' do
    priority_queue = PriorityQueue.new
    it 'Returns nil for an empty queue' do
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
  describe '#next' do
    next_queue = PriorityQueue.new
    it 'Returns nil for an empty queue' do
      expect(next_queue.next).to eq(nil)
    end
    it 'Returns the highest priority value for a non-empty queue' do
      next_queue.enqueue('low', 1)
      next_queue.enqueue('high', 2)
      expect(next_queue.next).to eq('high')
    end
    it "Doesn't affect the queue" do
      next_queue.next
      expect(next_queue.dequeue).to eq('high')
    end
  end
  describe '#find_priority' do
    find_queue = PriorityQueue.new
    find_queue.enqueue('low', 1)
    find_queue.enqueue('mid', 2)
    find_queue.enqueue('high', 3)
    it 'Returns priority of element' do
      expect(find_queue.find_priority('mid')).to eq(2)
    end
    it 'Returns nil when no such element exists' do
      expect(find_queue.find_priority('no such element')).to eq(nil)
    end
  end
  describe '#position' do
    position_queue = PriorityQueue.new
    position_queue.enqueue('mid', 2)
    position_queue.enqueue('low', 1)
    position_queue.enqueue('high', 3)
    it 'Returns 1 for next element in queue' do
      expect(position_queue.position(position_queue.next)).to eq(1)
    end
    it 'Returns correct number for other elements' do
      expect(position_queue.position('mid')).to eq(2)
    end
    it 'Returns nil for element not in queue' do
      expect(position_queue.position('oops')).to eq(nil)
    end
  end
  describe '#change_priority' do
    change_queue = PriorityQueue.new
    change_queue.enqueue('mid', 2)
    change_queue.enqueue('low', 1)
    change_queue.enqueue('high', 3)
    it 'Creates new element when value not found' do
      change_queue.change_priority('new', 4)
      expect(change_queue.next).to eq('new')
    end
    it 'Raises priority' do
      change_queue.change_priority('mid', 5)
      expect(change_queue.next).to eq('mid')
    end
    it 'Reduces priority' do
      change_queue.change_priority('mid', 2)
      expect(change_queue.next).to_not eq('mid')
    end
  end
end
