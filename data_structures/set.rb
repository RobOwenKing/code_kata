class Set
  def initialize(array = [])
    @set = array.uniq
  end

  def length
    @set.length
  end
end
