FULL = {
  none: proc { true },
  left: proc { false },
  right: proc { false },
  two: proc { |left, right| left.iterate(FULL) && right.iterate(FULL) }
}

DEGENERATE = {
  none: proc { true },
  left: proc { |left, _right| left.iterate(DEGENERATE) },
  right: proc { |_left, right| right.iterate(DEGENERATE) },
  two: proc { false }
}

HEIGHT = {
  none: proc { 1 },
  left: proc { |left, _right| left.iterate(HEIGHT) + 1 },
  right: proc { |_left, right| right.iterate(HEIGHT) + 1 },
  two: proc { |left, right| [left.iterate(HEIGHT), right.iterate(HEIGHT)].max + 1 }
}

BALANCED = {
  none: proc { true },
  left: proc { |left, _right| left.left.nil? && left.right.nil? },
  right: proc { |_left, right| right.left.nil? && right.right.nil? },
  two: proc do |left, right|
    left.iterate(BALANCED) && right.iterate(BALANCED) && (left.iterate(HEIGHT) - right.iterate(HEIGHT)).abs <= 1
  end
}
