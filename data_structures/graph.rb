# frozen_string_literal: true

# Contents
# - class Graph
# - - - #initialize
# - - Vertex Crud
# - - - #add_vertex
# - - - #delete_vertex
# - - - #vertices
# - - - #order
# - - Edge Crud
# - - - #add_edge
# - - - #delete_edge
# - - - #edges
# - - - #size
# - - Vertex Properties
# - - - #neighbours
# - - - #adjacent?
# - private
# - - - #add_directed_edge
# - - - #delete_directed_edge

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

  # VERTEX CRUD

  def add_vertex(value)
    return nil if @graph[value]

    @graph[value] = @weighted ? { neighbours: [], weights: [] } : { neighbours: [] }
    value
  end

  def delete_vertex(value)
    return nil unless @graph[value]

    neighbours = @graph[value][:neighbours]
    neighbours.each { |n| delete_directed_edge(n, value) }

    @graph.delete(value)
    value
  end

  def vertices
    @graph.keys
  end

  def order
    vertices.length
  end

  # EDGE CRUD

  def add_edge(vertex1, vertex2)
    return nil unless @graph[vertex1] && @graph[vertex2]

    returnable1 = add_directed_edge(vertex1, vertex2)
    returnable2 = @directed ? true : add_directed_edge(vertex2, vertex1)

    returnable1 && returnable2
  end

  def delete_edge(vertex1, vertex2)
    return nil unless @graph[vertex1] && @graph[vertex2]

    returnable1 = delete_directed_edge(vertex1, vertex2)
    returnable2 = @directed ? true : delete_directed_edge(vertex2, vertex1)

    returnable1 && returnable2
  end

  def edges
    returnable = []

    vertices.each do |vtx|
      @graph[vtx][:neighbours].each do |nbr|
        returnable << [vtx, nbr] unless returnable.any? { |e| e[0] == nbr && e[1] == vtx }
      end
    end

    returnable
  end

  def size
    count = 0
    @graph.each_value { |v| count += v[:neighbours].length }

    @directed ? count : count / 2
  end

  # VERTEX PROPERTIES

  def neighbours(vertex)
    return nil unless @graph[vertex]

    @graph[vertex][:neighbours]
  end

  def adjacent?(vertex1, vertex2)
    return nil unless @graph[vertex1] && @graph[vertex2]

    @graph[vertex1][:neighbours].include?(vertex2)
  end

  private

  def add_directed_edge(vertex1, vertex2)
    return false if @graph[vertex1][:neighbours].include?(vertex2)

    @graph[vertex1][:neighbours] << vertex2
    true
  end

  def delete_directed_edge(vertex1, vertex2)
    return false unless @graph[vertex1][:neighbours].include?(vertex2)

    @graph[vertex1][:neighbours].delete(vertex2)
    true
  end
end
