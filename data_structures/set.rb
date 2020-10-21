# Note, Ruby's standard libraries include a Set class
# Also, this is built using Arrays as an exercise
# In a real use case, a Hash would likely be preferable

class Set
  def initialize(array = [])
    # We want only unique values in our array
    # Sorting it now will be useful later
    @set = array.uniq.sort
  end

  def length
    @set.length
  end

  def add(val)
    return nil if @set.include?(val)

    if @set.empty? || val > @set[-1]
      @set.push(val)
    else
      pos = @set.bsearch_index { |element| element > val }
      @set.insert(pos, val)
    end
  end
end
