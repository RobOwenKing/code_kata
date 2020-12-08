FULL = {
  both: proc { true },
  neither: proc { |left, right| left.iterate(FULL) && right.iterate(FULL) },
  left: proc { false },
  right: proc { false }
}

DEGENERATE = {
  both: proc { true },
  neither: proc { false },
  left: proc { |_left, right| right.iterate(DEGENERATE) },
  right: proc { |left, _right| left.iterate(DEGENERATE) }
}

HEIGHT = {
  both: proc { 1 },
  neither: proc { |left, right| [left.iterate(HEIGHT), right.iterate(HEIGHT)].max + 1 },
  left: proc { |_left, right| right.iterate(HEIGHT) + 1 },
  right: proc { |left, _right| left.iterate(HEIGHT) + 1 }
}

BALANCED = {
  both: proc { true },
  neither: proc do |left, right|
    left.iterate(BALANCED) && right.iterate(BALANCED) && (left.iterate(HEIGHT) - right.iterate(HEIGHT)).abs <= 1
  end,
  left: proc { |_left, right| right.left.nil? && right.right.nil? },
  right: proc { |left, _right| left.left.nil? && left.right.nil? }
}
