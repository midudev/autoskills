# typed: true
# frozen_string_literal: true

require "tsort"

module Packwerk
  # A general implementation of a graph data structure with the ability to check for - and list - cycles.
  class Graph
    include TSort

    extend T::Sig
    sig do
      params(
        # The edges of the graph; represented as an Hash of Arrays.
        edges: T::Hash[T.any(String, Integer, NilClass), T::Array[T.any(String, Integer, NilClass)]]
      ).void
    end
    def initialize(edges)
      @edges = edges
    end

    def cycles
      @cycles ||= strongly_connected_components.reject { _1.size == 1 }
    end

    def acyclic?
      cycles.empty?
    end

    private def tsort_each_node(&block)
      @edges.each_key(&block)
    end

    EMPTY_ARRAY = [].freeze
    private_constant :EMPTY_ARRAY

    private def tsort_each_child(node, &block)
      (@edges[node] || EMPTY_ARRAY).each(&block)
    end
  end

  private_constant :Graph
end
