# frozen_string_literal: true

FULL = {
  none: proc { true },
  left: proc { false },
  right: proc { false },
  two: proc { |left, right, _value| left.iterate(FULL) && right.iterate(FULL) }
}.freeze

DEGENERATE = {
  none: proc { true },
  left: proc { |left, _right, _value| left.iterate(DEGENERATE) },
  right: proc { |_left, right, _value| right.iterate(DEGENERATE) },
  two: proc { false }
}.freeze

HEIGHT = {
  none: proc { 1 },
  left: proc { |left, _right, _value| left.iterate(HEIGHT) + 1 },
  right: proc { |_left, right, _value| right.iterate(HEIGHT) + 1 },
  two: proc { |left, right, _value| [left.iterate(HEIGHT), right.iterate(HEIGHT)].max + 1 }
}.freeze

BALANCED = {
  none: proc { true },
  left: proc { |left, _right, _value| left.left.nil? && left.right.nil? },
  right: proc { |_left, right, _value| right.left.nil? && right.right.nil? },
  two: proc do |left, right, _value|
    left.iterate(BALANCED) && right.iterate(BALANCED) && (left.iterate(HEIGHT) - right.iterate(HEIGHT)).abs <= 1
  end
}.freeze

SUM = {
  none: proc { |_left, _right, value| value },
  left: lambda do |left, _right, value|
    left_sum = left.iterate(SUM)
    return false if !left_sum || left_sum != value

    return left_sum + value
  end,
  right: lambda do |_left, right, value|
    right_sum = right.iterate(SUM)
    return false if !right_sum || right_sum != value

    return right_sum + value
  end,
  two: lambda do |left, right, value|
    left_sum = left.iterate(SUM)
    right_sum = right.iterate(SUM)
    return false if !left_sum || !right_sum || right_sum + left_sum != value

    return right_sum + left_sum + value
  end
}.freeze

SEARCHABLE = {
  none: proc { |_left, _right, value| [value] },
  left: lambda do |left, _right, value|
    left_nodes = left.iterate(SEARCHABLE)
    return false if !left_nodes || left_nodes.any? { |node| node > value }

    return left_nodes << value
  end,
  right: lambda do |_left, right, value|
    right_nodes = right.iterate(SEARCHABLE)
    return false if !right_nodes || right_nodes.any? { |node| node < value }

    return right_nodes << value
  end,
  two: lambda do |left, right, value|
    left_nodes = left.iterate(SEARCHABLE)
    right_nodes = right.iterate(SEARCHABLE)
    return false if !left_nodes || left_nodes.any? { |node| node > value }
    return false if !right_nodes || right_nodes.any? { |node| node < value }

    nodes = left_nodes + right_nodes
    return nodes << value
  end
}.freeze
