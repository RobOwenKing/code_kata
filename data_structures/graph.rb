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

  def add_vertex(value)
    return nil if @graph[value]

    @graph[value] = @weighted ? { neighbours: [], weights: [] } : { neighbours: [] }
    value
  end

  def delete_vertex(value)
    return nil unless @graph[value]

    @graph.delete(value)
    value
  end

  def vertices
    @graph.keys
  end

  def add_edge(vertex1, vertex2)
    return nil if !@graph[vertex1] || !@graph[vertex2]

    returnable1 = add_directed_edge(vertex1, vertex2)
    returnable2 = @directed ? true : add_directed_edge(vertex2, vertex1)

    returnable1 && returnable2
  end

  def neighbours(vertex)
    return nil if !@graph[vertex]

    @graph[vertex][:neighbours]
  end

  private

  def add_directed_edge(vertex1, vertex2)
    @graph[vertex1][:neighbours] << vertex2
  end
end
