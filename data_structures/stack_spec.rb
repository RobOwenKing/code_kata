require 'rspec'
require_relative 'stack'

RSpec.describe Stack do
  describe 'Basics' do
    it 'Can create a stack object' do
      expect(Stack.new.class).to eql(Stack)
    end
  end
  describe '#empty' do
    it 'Returns true if the stack is empty' do
      expect(Stack.new.empty?).to eql(true)
    end
    it 'Returns false if the stack is not empty' do
      stack = Stack.new
      stack.push(0)
      expect(stack.empty?).to eql(false)
    end
  end
  describe '#push' do
    it 'Returns correct position of first pushed element' do
      expect(Stack.new.push(1)).to eql(0)
    end
    it 'Returns correct position of third pushed element' do
      stack = Stack.new
      stack.push(3)
      stack.push(2)
      expect(stack.push(1)).to eql(2)
    end
  end
  describe '#pop' do
    it 'Returns nil if the stack is empty' do
      expect(Stack.new.pop).to eql(nil)
    end
    it 'Returns correct element for a stack of length 1' do
      stack = Stack.new
      stack.push('Hello world')
      expect(stack.pop).to eql('Hello world')
    end
    it 'Returns the correct element for a stack of length 3' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      stack.push('c')
      expect(stack.pop).to eql('c')
    end
    it 'Handles a second pop correctly' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      stack.push('c')
      stack.pop
      expect(stack.pop).to eql('b')
    end
  end
end
