# ???

class Node
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node

    return unless !@next.nil? && @next.class != Node

    raise ArgumentError, 'next_node must be Node or nil'
  end
end
