# Note, Ruby's standard libraries include a Set class
# Also, this is built using Arrays as an exercise
# In a real use case, a Hash might be preferable for speed

# Contents
# - class Set
# - - #initialize
# - - #length
# - - #add(val)
# - - #include?(val)
# - - #delete(val)
# - - #union(other_set)
# - - #intersection(other_set)
# - - #difference(other_set)
# - - #subset?(other_set)

class Set
  attr_reader :set

  def initialize(array = [])
    # We want only unique values in our Set
    @set = array.uniq
  end

  def length
    @set.length
  end

  # To maintain uniqueness, only add elements not already in our Set
  def add(val)
    @set.include?(val) ? nil : @set.push(val)
  end

  def include?(val)
    @set.include?(val)
  end

  def delete(val)
    include?(val) ? @set.delete(val) : nil
  end

  # a.union(b) returns Set of elements in a and/or b
  def union(other_set)
    new_set = @set
    # Create an array with elements that are members of either set
    other_set.set.each do |element|
      new_set.push(element)
    end
    Set.new(new_set)
  end

  # a.intersection(b) returns Set of elements in a and b
  def intersection(other_set)
    new_set = []
    # Fill our empty array with elements that are members of both sets
    other_set.set.each do |element|
      new_set.push(element) if @set.include?(element)
    end
    Set.new(new_set)
  end

  # a.difference(b) returns Set of elements of a not in b
  def difference(other_set)
    new_set = @set
    # Delete elements from our array that are in the other set
    other_set.set.each do |element|
      new_set.delete(element)
    end
    Set.new(new_set)
  end

  # a.subset?(b) returns true if b is a subset of a
  def subset?(other_set)
    other_set.set.all? { |element| include?(element) }
  end
end
