# This uses my Stack class to solve the matching parentheses problem
require_relative('../data_structures/stack.rb')

class String
  def matching?
    stack = Stack.new
    opening = ['(', '[', '{']
    closing = [')', ']', '}']

    self.each_char do |char|
      if opening.include?(char)
        stack.push(char)
      elsif closing.include?(char)
        return false if opening[closing.index(char)] != stack.peek

        stack.pop
      end
    end

    stack.empty?
  end
end
