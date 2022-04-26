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

      expect(@graph.add_vertex(1)).to eql(1)
      expect(@graph.add_vertex('a')).to eql('a')
      expect(@graph.add_vertex(1)).to eql(nil)
    end
  end

  describe '#delete_vertex' do
    it 'returns expected values' do
      @graph = Graph.new

      expect(@graph.add_vertex(1)).to eql(1)
      expect(@graph.delete_vertex(1)).to eql(1)
      expect(@graph.delete_vertex('a')).to eql(nil)
      expect(@graph.delete_vertex(1)).to eql(nil)
    end

    it 'deletes the given vertex' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.delete_vertex(1)

      expect(@graph.vertices.include?(2)).to eq(true)
      expect(@graph.vertices.include?(1)).to eq(false)
    end

    it 'deletes all adjacent edges in an undirected graph' do
      @graph = Graph.new

      @graph.add_vertex(1)
      @graph.add_vertex(2)
      @graph.add_vertex(3)

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
    it 'works correctly for an empty graph'
    it 'works correctly for a larger graph'
  end

  describe '#neighbours' do
    it 'works correctly for an isolated vertex'
    it 'works correctly for non-isolated vertices'
    it 'returns nil if no such vertex exists'
  end
end
