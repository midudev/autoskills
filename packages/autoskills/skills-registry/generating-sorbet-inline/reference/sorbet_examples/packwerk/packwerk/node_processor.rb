# typed: strict
# frozen_string_literal: true

module Packwerk
  # Processes a single node in an abstract syntax tree (AST) using the provided checkers.
  class NodeProcessor
    extend T::Sig

    sig do
      params(
        reference_extractor: ReferenceExtractor,
        relative_file: String,
      ).void
    end
    def initialize(reference_extractor:, relative_file:)
      @reference_extractor = reference_extractor
      @relative_file = relative_file
    end

    sig do
      params(
        node: Parser::AST::Node,
        ancestors: T::Array[Parser::AST::Node]
      ).returns(T.nilable(UnresolvedReference))
    end
    def call(node, ancestors)
      return unless NodeHelpers.method_call?(node) || NodeHelpers.constant?(node)

      @reference_extractor.reference_from_node(node, ancestors: ancestors, relative_file: @relative_file)
    end
  end

  private_constant :NodeProcessor
end
