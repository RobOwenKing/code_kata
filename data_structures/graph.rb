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
# - - Graph Properties
# - - - #max_degree
# - - - #min_degree
# - - - #regular?
# - - Vertex Properties
# - - - #adjacent?
# - - - #degree
# - - - #neighbours
# - - Transformations
# - - - #complement
# - private
# - - - #add_directed_edge
# - - - #delete_directed_edge

# Class for simple graphs (ie: no loops or multiedges allowed)
# NB: directed and weighted params are WIP
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
    return false if vertex1 == vertex2

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
    @directed ? degrees.sum : degrees.sum / 2
  end

  # GRAPH PROPERTIES

  def max_degree
    degrees.max
  end

  def min_degree
    degrees.min
  end

  def regular?
    return nil if @graph.keys.length.zero?

    uniqs = degrees.uniq
    uniqs.length == 1 ? uniqs[0] : false
  end

  # VERTEX PROPERTIES

  def adjacent?(vertex1, vertex2)
    return nil unless @graph[vertex1] && @graph[vertex2]

    @graph[vertex1][:neighbours].include?(vertex2)
  end

  def degree(vertex)
    return nil unless @graph[vertex]

    @graph[vertex][:neighbours].length
  end

  def neighbours(vertex)
    return nil unless @graph[vertex]

    @graph[vertex][:neighbours]
  end

  # Transformations

  def complement
    @complement = Graph.new

    vertices.each { |v| @complement.add_vertex(v) }

    # Cannot merge with above because we need all vertices created first
    # Otherwise edges will not create (at least in directed graphs)
    vertices.each do |v1|
      vertices.each { |v2| @complement.add_edge(v1, v2) unless v1 == v2 || neighbours(v1).include?(v2) }
    end

    @complement
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

  def degrees
    @graph.values.collect { |k| k[:neighbours].length }
  end
end
