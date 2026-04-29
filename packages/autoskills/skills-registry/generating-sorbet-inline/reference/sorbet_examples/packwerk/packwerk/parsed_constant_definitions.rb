# typed: strict
# frozen_string_literal: true

require "ast/node"

module Packwerk
  # A collection of constant definitions parsed from an Abstract Syntax Tree (AST).
  class ParsedConstantDefinitions
    extend T::Sig

    class << self
      extend T::Sig

      # What fully qualified constants can this constant refer to in this context?
      sig { params(constant_name: String, namespace_path: T::Array[T.nilable(String)]).returns(T::Array[String]) }
      def reference_qualifications(constant_name, namespace_path:)
        return [constant_name] if constant_name.start_with?("::")

        resolved_constant_name = "::#{constant_name}"

        possible_namespaces = namespace_path.each_with_object([""]) do |current, acc|
          acc << "#{acc.last}::#{current}" if current
        end

        possible_namespaces.map { |namespace| namespace + resolved_constant_name }
      end
    end

    sig { params(root_node: T.nilable(AST::Node)).void }
    def initialize(root_node:)
      @local_definitions = T.let({}, T::Hash[String, T.nilable(Node::Location)])

      collect_local_definitions_from_root(root_node) if root_node
    end

    sig do
      params(
        constant_name: String,
        location: T.nilable(Node::Location),
        namespace_path: T::Array[String],
      ).returns(T::Boolean)
    end
    def local_reference?(constant_name, location: nil, namespace_path: [])
      qualifications = self.class.reference_qualifications(constant_name, namespace_path: namespace_path)

      qualifications.any? do |name|
        @local_definitions[name] &&
          @local_definitions[name] != location
      end
    end

    private

    sig { params(node: AST::Node, current_namespace_path: T::Array[T.nilable(String)]).void }
    def collect_local_definitions_from_root(node, current_namespace_path = [])
      if NodeHelpers.constant_assignment?(node)
        add_definition(NodeHelpers.constant_name(node), current_namespace_path, NodeHelpers.name_location(node))
      elsif NodeHelpers.module_name_from_definition(node)
        # handle compact constant nesting (e.g. "module Sales::Order")
        tempnode = T.let(node, T.nilable(AST::Node))
        while (tempnode = NodeHelpers.each_child(T.must(tempnode)).find { |node| NodeHelpers.constant?(node) })
          add_definition(NodeHelpers.constant_name(tempnode), current_namespace_path,
            NodeHelpers.name_location(tempnode))
        end

        current_namespace_path += NodeHelpers.class_or_module_name(node).split("::")
      end

      NodeHelpers.each_child(node) { |child| collect_local_definitions_from_root(child, current_namespace_path) }
    end

    sig do
      params(
        constant_name: String,
        current_namespace_path: T::Array[T.nilable(String)],
        location: T.nilable(Node::Location),
      ).void
    end
    def add_definition(constant_name, current_namespace_path, location)
      resolved_constant = [""].concat(current_namespace_path).push(constant_name).join("::")

      @local_definitions[resolved_constant] = location
    end
  end

  private_constant :ParsedConstantDefinitions
end
