# frozen_string_literal: true

require 'rspec'
require_relative 'graph'

# Gives us a deep_equals? function
require_relative '../array_methods/array_methods'

RSpec.describe Graph do
  describe '#initialize' do
    it 'creates a Graph object' do
      expect(Graph.new.class).to eql(Graph)
    end

    it 'gives new Graph the expected default properties' do
      @graph = Graph.new

      expect(@graph.directed).to eql(false)
      expect(@graph.weighted).to eql(false)
    end

    it 'gives new Graph the expected passed properties' do
      @graph = Graph.new(directed: true, weighted: true)

      expect(@graph.directed).to eql(true)
      expect(@graph.weighted).to eql(true)
    end
  end

  describe '#add_vertex' do
    it 'returns expected values' do
      @graph = Graph.new

      # Return value itself if new vertex created
      expect(@graph.add_vertex(1)).to eql(1)
      expect(@graph.add_vertex('a')).to eql('a')
      # Return nil if value given is a duplicate
      expect(@graph.add_vertex(1)).to eql(nil)
    end
  end

  describe '#delete_vertex' do
    before do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)
    end

    it 'returns expected values' do
      # Return value of deleted node
      expect(@graph.delete_vertex(1)).to eql(1)
      # Return nil if no such node can be found for deletion
      expect(@graph.delete_vertex('a')).to eql(nil)
      expect(@graph.delete_vertex(1)).to eql(nil)
    end

    it 'deletes the given vertex' do
      @graph.delete_vertex(1)

      expect(@graph.vertices.include?(2)).to eq(true)
      expect(@graph.vertices.include?(1)).to eq(false)
    end

    it 'deletes all adjacent edges in an undirected graph' do
      @graph.add_edge(1, 2)
      @graph.add_edge(1, 3)

      @graph.delete_vertex(2)

      expect(deep_equals?(@graph.neighbours(1), [3])).to eq(true)
      expect(deep_equals?(@graph.neighbours(3), [1])).to eq(true)
    end
  end

  describe '#add_edge' do
    it 'adds to both vertices in an undirected graph' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      @graph.add_edge(1, 2)

      expect(@graph.neighbours(1).include?(2)).to eq(true)
      expect(@graph.neighbours(2).include?(1)).to eq(true)
    end

    it 'adds to only one vertex in a directed graph' do
      @graph = Graph.new(directed: true)

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      @graph.add_edge(1, 2)

      expect(@graph.neighbours(1).include?(2)).to eq(true)
      expect(@graph.neighbours(2).include?(1)).to eq(false)
    end

    it 'returns true or false if both params exist' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      # Return true if an edge has been created
      expect(@graph.add_edge(1, 2)).to eq(true)
      # Return false if no edge was created (because duplicate)
      expect(@graph.add_edge(1, 2)).to eq(false)
    end

    it 'returns nil if one or both params does not exist' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      expect(@graph.add_edge(1, 3)).to eq(nil)
      expect(@graph.add_edge(4, 2)).to eq(nil)
    end
  end

  describe '#delete_edge' do
    it 'works correctly in an undirected graph' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      @graph.add_edge(1, 2)
      @graph.delete_edge(2, 1)

      expect(@graph.neighbours(1).include?(2)).to eq(false)
      expect(@graph.neighbours(2).include?(1)).to eq(false)
    end

    it 'works correctly in a directed graph' do
      @graph = Graph.new(directed: true)

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      @graph.add_edge(1, 2)
      @graph.delete_edge(2, 1)

      expect(@graph.neighbours(1).include?(2)).to eq(true)
      expect(@graph.neighbours(2).include?(1)).to eq(false)

      @graph.delete_edge(1, 2)

      expect(@graph.neighbours(1).include?(2)).to eq(false)
      expect(@graph.neighbours(2).include?(1)).to eq(false)
    end

    it 'returns true or false if both params exist' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_edge(1, 2)

      # Return true if an edge has been deleted
      expect(@graph.delete_edge(1, 2)).to eq(true)
      # Return false if no edge existed between given vertices
      expect(@graph.delete_edge(1, 2)).to eq(false)
    end

    it 'returns nil if one or both params does not exist' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      expect(@graph.delete_edge(1, 3)).to eq(nil)
      expect(@graph.delete_edge(4, 2)).to eq(nil)
    end
  end

  describe '#vertices' do
    it 'works correctly for an empty graph' do
      @graph = Graph.new

      expect(@graph.vertices.class).to eq(Array)
      expect(@graph.vertices.length).to eq(0)
    end

    it 'works correctly for a larger graph' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)
      @graph.delete_vertex(2)

      expect(deep_equals?(@graph.vertices, [1, 3])).to eq(true)
    end
  end

  describe '#edges' do
    it 'works correctly for an empty graph' do
      @graph = Graph.new

      expect(@graph.edges.class).to eq(Array)
      expect(@graph.edges.length).to eq(0)

      @graph.add_vertex(1)
      @graph.add_vertex(2)

      expect(@graph.edges.class).to eq(Array)
      expect(@graph.edges.length).to eq(0)
    end

    it 'works correctly for a larger graph' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)

      @graph.add_edge(1, 2)
      @graph.add_edge(1, 3)

      expect(deep_equals?(@graph.edges, [[1, 2], [1, 3]])).to eq(true)
    end
  end

  describe '#neighbours' do
    before do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)
      @graph.add_edge(1, 2)
    end

    it 'works correctly for an isolated vertex' do
      expect(deep_equals?(@graph.neighbours(3), [])).to eq(true)
    end

    it 'works correctly for non-isolated vertices' do
      expect(deep_equals?(@graph.neighbours(1), [2])).to eq(true)
      expect(deep_equals?(@graph.neighbours(2), [1])).to eq(true)
    end

    it 'returns nil if no such vertex exists' do
      expect(@graph.neighbours(4)).to eq(nil)
    end
  end

  describe '#adjacent?' do
    before do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)

      @graph.add_edge(1, 2)
    end

    it 'returns true if the vertices exist and are adjacent' do
      expect(@graph.adjacent?(1, 2)).to eq(true)
    end

    it 'returns false if the vertices exist and are not adjacent' do
      expect(@graph.adjacent?(1, 3)).to eq(false)
    end

    it 'returns nil if either vertex does not exit' do
      expect(@graph.adjacent?(1, 4)).to eq(nil)
      expect(@graph.adjacent?(4, 2)).to eq(nil)
    end
  end
end
