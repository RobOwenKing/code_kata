# frozen_string_literal: true

# Contents
# - class Graph
# - - - #initialize
# - - Vertex CRUD
# - - - #add_vertex
# - - - #delete_vertex
# - - - #vertices
# - - - #order
# - - Edge CRUD
# - - - #add_edge
# - - - #delete_edge
# - - - #edges
# - - - #size
# - - Graph Properties
# - - - #complete?
# - - - #connected?
# - - - #directed?
# - - - #max_degree
# - - - #min_degree
# - - - #regular?
# - - - #undirected?
# - - Vertex Properties
# - - - #adjacent?
# - - - #degree
# - - - #neighbours
# - - Transformations
# - - - #complement
# - - - #direct!
# - - - #lossless_undirect!
# - - - #lossy_undirect!
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
    # Prevent multiple vertices from having the same value
    return nil if @graph[value]

    @graph[value] = @weighted ? { neighbours: [], weights: [] } : { neighbours: [] }
    # Return value of vertex created
    value
  end

  def delete_vertex(value)
    return nil unless @graph[value] # ie: If there's no vertex with that value to delete

    # Delete all references to vertex to be deleted (incoming edges)
    # @todo This is optimised for undirected graphs and will break if @directed == true
    neighbours = @graph[value][:neighbours]
    neighbours.each { |n| delete_directed_edge(n, value) }

    @graph.delete(value)
    # Return value of vertex deleted
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
    return nil unless @graph[vertex1] && @graph[vertex2] # Both vertices must already exist
    return false if vertex1 == vertex2 # Prevent loops

    returnable1 = add_directed_edge(vertex1, vertex2)
    # Add inverse reference if the graph is undirected
    returnable2 = @directed ? true : add_directed_edge(vertex2, vertex1)

    returnable1 && returnable2
  end

  def delete_edge(vertex1, vertex2)
    return nil unless @graph[vertex1] && @graph[vertex2] # Both vertices must already exist

    returnable1 = delete_directed_edge(vertex1, vertex2)
    # Delete inverse reference if the graph is undirected
    returnable2 = @directed ? true : delete_directed_edge(vertex2, vertex1)

    returnable1 && returnable2
  end

  def edges
    returnable = []

    vertices.each do |vtx|
      @graph[vtx][:neighbours].each do |nbr|
        # @todo Implement for directed graphs too
        returnable << [vtx, nbr] unless returnable.any? { |e| e[0] == nbr && e[1] == vtx }
      end
    end

    returnable
  end

  def size
    # In an undirected graph, the sum of the degrees will count each edge twice (once from each end)
    # In a directed graph, each is counted only once (start vertex)
    @directed ? degrees.sum : degrees.sum / 2
  end

  # GRAPH PROPERTIES

  def complete?
    target = order - 1
    vertices.all? { |v| degree(v) == target }
  end

  def connected?
    return true if order.zero?

    to_visit = [vertices[0]] # Start with an arbitrary node
    found = [vertices[0]]
    target = order

    until to_visit.empty? || found.length == target
      neighbours(to_visit.shift).each do |n|
        unless found.include?(n)
          to_visit << n
          found << n
        end
      end
    end

    found.length == target
  end

  def directed?
    @directed
  end

  def max_degree
    degrees.max
  end

  def min_degree
    degrees.min
  end

  def regular?
    return nil if @graph.keys.length.zero?

    uniqs = degrees.uniq
    # If the graph is r-regular (only one unique degree), return relevant r
    # Else return false
    uniqs.length == 1 ? uniqs[0] : false
  end

  def undirected?
    !@directed
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

  def direct!
    @directed = true
  end

  def lossless_undirect!
    @directed = false

    vertices.each do |v|
      @graph[v][:neighbours].each { |n| add_edge(n, v) unless adjacent?(n, v) }
    end
  end

  def lossy_undirect!
    @directed = false

    vertices.each do |v|
      @graph[v][:neighbours].each { |n| delete_edge(v, n) unless adjacent?(n, v) }
    end
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
    @graph.values.collect { |vtx| vtx[:neighbours].length }
  end
end
