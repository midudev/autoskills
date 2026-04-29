# typed: strict
# frozen_string_literal: true

module Packwerk
  # Visits all nodes of an AST, processing them using a given node processor.
  class NodeVisitor
    extend T::Sig

    sig { params(node_processor: NodeProcessor).void }
    def initialize(node_processor:)
      @node_processor = node_processor
    end

    sig do
      params(
        node: Parser::AST::Node,
        ancestors: T::Array[Parser::AST::Node],
        result: T::Array[UnresolvedReference],
      ).void
    end
    def visit(node, ancestors:, result:)
      reference = @node_processor.call(node, ancestors)
      result << reference if reference

      child_ancestors = [node] + ancestors
      NodeHelpers.each_child(node) do |child|
        visit(child, ancestors: child_ancestors, result: result)
      end
    end
  end

  private_constant :NodeVisitor
end
