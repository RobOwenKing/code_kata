# frozen_string_literal: true

# Contents
# - class Graph
# - - #initialize

# Set class
class Graph
  attr_reader :directed, :weighted

  def initialize(vertices: [], directed: false, weighted: false)
    # I will encode graphs as a hash (instead of eg: Array of Vertex objects)
    # 1. For speed of lookup
    # 2. To do something different to eg: my BinaryTree class
    @graph = {}
    @directed = directed
    @weighted = weighted
    vertices.each { |v| add_vertex(v) }
  end

  def add_vertex(vertex)
    return false if graph[vertex]

    @graph[vertex] = @weighted ? { neighbours: [], weights: [] } : { neighbours: [] }
  end
end
