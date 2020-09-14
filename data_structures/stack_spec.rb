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

  describe '#peek' do
    it 'Returns nil if the stack is empty' do
      expect(Stack.new.peek).to eql(nil)
    end
    it 'Returns correct element for a stack of length 1' do
      stack = Stack.new
      stack.push('Hello world')
      expect(stack.peek).to eql('Hello world')
    end
    it 'Returns the correct element for a stack of length 3' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      stack.push('c')
      expect(stack.peek).to eql('c')
    end
    it 'Handles a peek after a pop correctly' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      stack.push('c')
      stack.pop
      expect(stack.peek).to eql('b')
    end
  end

  describe '#size' do
    it 'Gives correct size for an empty stack' do
      expect(Stack.new.size).to eql(0)
    end
    it 'Gives correct size for non-empty stack' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      expect(stack.size).to eql(2)
    end
    it 'Gives correct size after multiple pushes and pops' do
      stack = Stack.new
      stack.push('a')
      stack.push('b')
      stack.pop
      stack.push('c')
      stack.push('d')
      expect(stack.size).to eql(3)
    end
  end

  describe '#clear' do
    it 'Leaves the stack containing no elements' do
      stack = Stack.new
      stack.push('Hello world')
      stack.clear
      expect(stack.peek).to eql(nil)
    end
    it 'Leaves stack with size 0' do
      stack = Stack.new
      stack.push('Hello world')
      stack.clear
      expect(stack.size).to eql(0)
    end
  end
end
