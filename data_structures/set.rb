# Note, Ruby's standard libraries include a Set class
# Also, this is built using Arrays as an exercise
# In a real use case, a Hash would likely be preferable

class Set
  attr_reader :set

  def initialize(array = [])
    # We want only unique values in our array
    # Sorting it now will be useful later
    @set = array.uniq
  end

  def length
    @set.length
  end

  def add(val)
    @set.include?(val) ? nil : @set.push(val)
  end

  def include?(val)
    @set.include?(val)
  end

  def delete(val)
    include?(val) ? @set.delete(val) : nil
  end

  def union(other_set)
    new_set = @set
    other_set.set.each do |element|
      new_set.push(element) unless new_set.include?(element)
    end
    Set.new(new_set)
  end

  def intersection(other_set)
    new_set = []
    other_set.set.each do |element|
      new_set.push(element) if @set.include?(element)
    end
    Set.new(new_set)
  end

  def difference(other_set)
    new_set = @set
    other_set.set.each do |element|
      new_set.delete(element)
    end
    Set.new(new_set)
  end
end
