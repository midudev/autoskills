# typed: strict
# frozen_string_literal: true

module Packwerk
  # Extracts a possible constant reference from a given AST node.
  class ReferenceExtractor
    extend T::Sig

    class << self
      extend T::Sig

      sig do
        params(
          unresolved_references: T::Array[UnresolvedReference],
          context_provider: ConstantDiscovery
        ).returns(T::Array[Reference])
      end
      def get_fully_qualified_references_from(unresolved_references, context_provider)
        fully_qualified_references = T.let([], T::Array[Reference])

        unresolved_references.each do |unresolved_references_or_offense|
          unresolved_reference = unresolved_references_or_offense

          constant =
            context_provider.context_for(
              unresolved_reference.constant_name,
              current_namespace_path: unresolved_reference.namespace_path
            )

          next if constant.nil?

          package_for_constant = constant.package

          next if package_for_constant.nil?

          source_package = context_provider.package_from_path(unresolved_reference.relative_path)

          next if source_package == package_for_constant

          fully_qualified_references << Reference.new(
            package: source_package,
            relative_path: unresolved_reference.relative_path,
            constant: constant,
            source_location: unresolved_reference.source_location,
          )
        end

        fully_qualified_references
      end
    end

    sig do
      params(
        constant_name_inspectors: T::Array[ConstantNameInspector],
        root_node: AST::Node,
        root_path: String,
      ).void
    end
    def initialize(
      constant_name_inspectors:,
      root_node:,
      root_path:
    )
      @constant_name_inspectors = constant_name_inspectors
      @root_path = root_path
      @local_constant_definitions = T.let(
        ParsedConstantDefinitions.new(root_node: root_node),
        ParsedConstantDefinitions,
      )
    end

    sig do
      params(
        node: Parser::AST::Node,
        ancestors: T::Array[Parser::AST::Node],
        relative_file: String
      ).returns(T.nilable(UnresolvedReference))
    end
    def reference_from_node(node, ancestors:, relative_file:)
      constant_name = T.let(nil, T.nilable(String))

      @constant_name_inspectors.each do |inspector|
        constant_name = inspect_node(
          inspector,
          node: node,
          ancestors: ancestors,
          relative_file: relative_file
        )

        break if constant_name
      end

      if constant_name
        reference_from_constant(
          constant_name,
          node: node,
          ancestors: ancestors,
          relative_file: relative_file
        )
      end
    end

    private

    sig do
      params(
        inspector: ConstantNameInspector,
        node: Parser::AST::Node,
        ancestors: T::Array[Parser::AST::Node],
        relative_file: String
      ).returns(T.nilable(String))
    end
    def inspect_node(inspector, node:, ancestors:, relative_file:)
      inspector.constant_name_from_node(node, ancestors: ancestors, relative_file: relative_file)
    rescue ArgumentError => error
      if error.message == "unknown keyword: :relative_file"
        T.unsafe(inspector).constant_name_from_node(node, ancestors: ancestors).tap do
          warn(<<~MSG.squish)
            #{T.cast(inspector, Object).class}#reference_from_node without a relative_file: keyword
            argument is deprecated and will be required in Packwerk 3.1.1.
          MSG
        end
      else
        raise
      end
    end

    sig do
      params(
        constant_name: String,
        node: Parser::AST::Node,
        ancestors: T::Array[Parser::AST::Node],
        relative_file: String
      ).returns(T.nilable(UnresolvedReference))
    end
    def reference_from_constant(constant_name, node:, ancestors:, relative_file:)
      namespace_path = NodeHelpers.enclosing_namespace_path(node, ancestors: ancestors)

      return if local_reference?(constant_name, NodeHelpers.name_location(node), namespace_path)

      location = NodeHelpers.location(node)

      UnresolvedReference.new(
        constant_name: constant_name,
        namespace_path: namespace_path,
        relative_path: relative_file,
        source_location: location
      )
    end

    sig do
      params(
        constant_name: String,
        name_location: T.nilable(Node::Location),
        namespace_path: T::Array[String],
      ).returns(T::Boolean)
    end
    def local_reference?(constant_name, name_location, namespace_path)
      @local_constant_definitions.local_reference?(
        constant_name,
        location: name_location,
        namespace_path: namespace_path
      )
    end
  end

  private_constant :ReferenceExtractor
end
