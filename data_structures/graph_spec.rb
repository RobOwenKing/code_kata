# frozen_string_literal: true

require 'rspec'
require_relative 'graph'

RSpec.describe Graph do
  describe '#initialize' do
    it 'creates a Graph object' do
      expect(Graph.new.class).to eql(Graph)
    end

    it 'gives new Graph the expected default properties' do
      graph = Graph.new

      expect(graph.directed).to eql(false)
      expect(graph.weighted).to eql(false)
    end

    it 'gives new Graph the expected passed properties' do
      graph = Graph.new(directed: true, weighted: true)

      expect(graph.directed).to eql(true)
      expect(graph.weighted).to eql(true)
    end
  end

  describe '#add_vertex' do
    it 'returns expected values' do
      graph = Graph.new

      expect(graph.add_vertex(1)).to eql(1)
      expect(graph.add_vertex('a')).to eql('a')
      expect(graph.add_vertex(1)).to eql(nil)
    end
  end

  describe '#delete_vertex' do
    it 'returns expected values' do
      graph = Graph.new

      expect(graph.add_vertex(1)).to eql(1)
      expect(graph.delete_vertex(1)).to eql(1)
      expect(graph.delete_vertex('a')).to eql(nil)
      expect(graph.delete_vertex(1)).to eql(nil)
    end
    it 'deletes all adjacent edges'
  end

  describe '#add_edge' do
    it 'adds to both vertices in an undirected graph'
    it 'adds to only one vertex in a directed graph'
    it 'returns nil if one or both params does not exist'
  end

  describe '#delete_edge' do
    it 'works correctly in an undirected graph'
    it 'works correctly in a directed graph'
    it 'returns nil if one or both params does not exist'
  end

  describe '#vertices' do
    it 'works correctly for an empty graph'
    it 'works correctly for a larger graph'
  end

  describe '#edges' do
    it 'works correctly for an empty graph'
    it 'works correctly for a larger graph'
  end

  describes '#neighbours' do
    it 'works correctly for an isolated vertex'
    it 'works correctly for non-isolated vertices'
    it 'returns nil if no such vertex exists'
  end
end
