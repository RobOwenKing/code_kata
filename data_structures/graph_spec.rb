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
end
