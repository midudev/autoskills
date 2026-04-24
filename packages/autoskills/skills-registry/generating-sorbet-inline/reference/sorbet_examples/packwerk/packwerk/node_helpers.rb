# typed: strict
# frozen_string_literal: true

require "parser"
require "parser/ast/node"

module Packwerk
  # Convenience methods for working with Parser::AST::Node nodes.
  module NodeHelpers
    class TypeError < ArgumentError; end

    class << self
      extend T::Sig

      sig { params(class_or_module_node: AST::Node).returns(String) }
      def class_or_module_name(class_or_module_node)
        case type_of(class_or_module_node)
        when CLASS, MODULE
          # (class (const nil :Foo) (const nil :Bar) (nil))
          #   "class Foo < Bar; end"
          # (module (const nil :Foo) (nil))
          #   "module Foo; end"
          identifier = class_or_module_node.children[0]
          constant_name(identifier)
        else
          raise TypeError
        end
      end

      sig { params(constant_node: AST::Node).returns(String) }
      def constant_name(constant_node)
        case type_of(constant_node)
        when CONSTANT_ROOT_NAMESPACE
          ""
        when CONSTANT, CONSTANT_ASSIGNMENT, SELF
          # (const nil :Foo)
          #   "Foo"
          # (const (cbase) :Foo)
          #   "::Foo"
          # (const (lvar :a) :Foo)
          #   "a::Foo"
          # (casgn nil :Foo (int 1))
          #   "Foo = 1"
          # (casgn (cbase) :Foo (int 1))
          #   "::Foo = 1"
          # (casgn (lvar :a) :Foo (int 1))
          #   "a::Foo = 1"
          # (casgn (self) :Foo (int 1))
          #   "self::Foo = 1"
          namespace, name = constant_node.children

          if namespace
            [constant_name(namespace), name].join("::")
          else
            name.to_s
          end
        else
          raise TypeError
        end
      end

      sig do
        params(
          node: AST::Node,
          block: T.nilable(T.proc.params(arg0: Parser::AST::Node).void),
        ).returns(T::Enumerable[AST::Node])
      end
      def each_child(node, &block)
        if block
          node.children.each do |child|
            yield(child) if child.is_a?(Parser::AST::Node)
          end
        else
          enum_for(:each_child, node)
        end
      end

      sig { params(starting_node: AST::Node, ancestors: T::Array[AST::Node]).returns(T::Array[String]) }
      def enclosing_namespace_path(starting_node, ancestors:)
        ancestors.select { |n| [CLASS, MODULE].include?(type_of(n)) }
          .each_with_object([]) do |node, namespace|
          # when evaluating `class Child < Parent`, the const node for `Parent` is a child of the class
          # node, so it'll be an ancestor, but `Parent` is not evaluated in the namespace of `Child`, so
          # we need to skip it here
          next if type_of(node) == CLASS && parent_class(node) == starting_node

          namespace.prepend(class_or_module_name(node))
        end
      end

      sig { params(string_or_symbol_node: AST::Node).returns(T.any(String, Symbol)) }
      def literal_value(string_or_symbol_node)
        case type_of(string_or_symbol_node)
        when STRING, SYMBOL
          # (str "foo")
          #   "'foo'"
          # (sym :foo)
          #   ":foo"
          string_or_symbol_node.children[0]
        else
          raise TypeError
        end
      end

      sig { params(node: Parser::AST::Node).returns(Node::Location) }
      def location(node)
        location = node.location
        Node::Location.new(location.line, location.column)
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def constant?(node)
        type_of(node) == CONSTANT
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def constant_assignment?(node)
        type_of(node) == CONSTANT_ASSIGNMENT
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def class?(node)
        type_of(node) == CLASS
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def method_call?(node)
        type_of(node) == METHOD_CALL
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def hash?(node)
        type_of(node) == HASH
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def string?(node)
        type_of(node) == STRING
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def symbol?(node)
        type_of(node) == SYMBOL
      end

      sig { params(method_call_node: AST::Node).returns(T::Array[AST::Node]) }
      def method_arguments(method_call_node)
        raise TypeError unless method_call?(method_call_node)

        # (send (lvar :foo) :bar (int 1))
        #   "foo.bar(1)"
        method_call_node.children.slice(2..-1)
      end

      sig { params(method_call_node: AST::Node).returns(Symbol) }
      def method_name(method_call_node)
        raise TypeError unless method_call?(method_call_node)

        # (send (lvar :foo) :bar (int 1))
        #   "foo.bar(1)"
        method_call_node.children[1]
      end

      sig { params(node: AST::Node).returns(T.nilable(String)) }
      def module_name_from_definition(node)
        case type_of(node)
        when CLASS, MODULE
          # "class My::Class; end"
          # "module My::Module; end"
          class_or_module_name(node)
        when CONSTANT_ASSIGNMENT
          # "My::Class = ..."
          # "My::Module = ..."
          rvalue = node.children.last

          case type_of(rvalue)
          when METHOD_CALL
            # "Class.new"
            # "Module.new"
            constant_name(node) if module_creation?(rvalue)
          when BLOCK
            # "Class.new do end"
            # "Module.new do end"
            constant_name(node) if module_creation?(method_call_node(rvalue))
          end
        end
      end

      sig { params(node: AST::Node).returns(T.nilable(Node::Location)) }
      def name_location(node)
        location = T.cast(node, Parser::AST::Node).location

        if location.respond_to?(:name)
          name = location.name
          Node::Location.new(name.line, name.column)
        end
      end

      sig { params(class_node: AST::Node).returns(T.nilable(AST::Node)) }
      def parent_class(class_node)
        raise TypeError unless type_of(class_node) == CLASS

        # (class (const nil :Foo) (const nil :Bar) (nil))
        #   "class Foo < Bar; end"
        class_node.children[1]
      end

      sig { params(ancestors: T::Array[AST::Node]).returns(String) }
      def parent_module_name(ancestors:)
        definitions = ancestors
          .select { |n| [CLASS, MODULE, CONSTANT_ASSIGNMENT, BLOCK].include?(type_of(n)) }

        names = definitions.map do |definition|
          name_part_from_definition(definition)
        end.compact

        names.empty? ? "Object" : names.reverse.join("::")
      end

      sig { params(hash_node: AST::Node, key: Symbol).returns(T.untyped) }
      def value_from_hash(hash_node, key)
        raise TypeError unless hash?(hash_node)

        pair = hash_pairs(hash_node).detect { |pair_node| literal_value(hash_pair_key(pair_node)) == key }
        hash_pair_value(pair) if pair
      end

      private

      BLOCK = :block
      CLASS = :class
      CONSTANT = :const
      CONSTANT_ASSIGNMENT = :casgn
      CONSTANT_ROOT_NAMESPACE = :cbase
      HASH = :hash
      HASH_PAIR = :pair
      METHOD_CALL = :send
      MODULE = :module
      SELF = :self
      STRING = :str
      SYMBOL = :sym

      private_constant(
        :BLOCK, :CLASS, :CONSTANT, :CONSTANT_ASSIGNMENT, :CONSTANT_ROOT_NAMESPACE, :HASH, :HASH_PAIR, :METHOD_CALL,
        :MODULE, :SELF, :STRING, :SYMBOL,
      )

      sig { params(node: AST::Node).returns(Symbol) }
      def type_of(node)
        node.type
      end

      sig { params(hash_pair_node: AST::Node).returns(T.untyped) }
      def hash_pair_key(hash_pair_node)
        raise TypeError unless type_of(hash_pair_node) == HASH_PAIR

        # (pair (int 1) (int 2))
        #   "1 => 2"
        # (pair (sym :answer) (int 42))
        #   "answer: 42"
        hash_pair_node.children[0]
      end

      sig { params(hash_pair_node: AST::Node).returns(T.untyped) }
      def hash_pair_value(hash_pair_node)
        raise TypeError unless type_of(hash_pair_node) == HASH_PAIR

        # (pair (int 1) (int 2))
        #   "1 => 2"
        # (pair (sym :answer) (int 42))
        #   "answer: 42"
        hash_pair_node.children[1]
      end

      sig { params(hash_node: AST::Node).returns(T::Array[AST::Node]) }
      def hash_pairs(hash_node)
        raise TypeError unless hash?(hash_node)

        # (hash (pair (int 1) (int 2)) (pair (int 3) (int 4)))
        #   "{1 => 2, 3 => 4}"
        hash_node.children.select { |n| type_of(n) == HASH_PAIR }
      end

      sig { params(block_node: AST::Node).returns(AST::Node) }
      def method_call_node(block_node)
        raise TypeError unless type_of(block_node) == BLOCK

        # (block (send (lvar :foo) :bar) (args) (int 42))
        #   "foo.bar do 42 end"
        block_node.children[0]
      end

      sig { params(node: AST::Node).returns(T::Boolean) }
      def module_creation?(node)
        # "Class.new"
        # "Module.new"
        method_call?(node) &&
          dynamic_class_creation?(receiver(node)) &&
          method_name(node) == :new
      end

      sig { params(node: T.nilable(AST::Node)).returns(T::Boolean) }
      def dynamic_class_creation?(node)
        !!node &&
          constant?(node) &&
          ["Class", "Module"].include?(constant_name(node))
      end

      sig { params(node: AST::Node).returns(T.nilable(String)) }
      def name_from_block_definition(node)
        if method_name(method_call_node(node)) == :class_eval
          receiver = receiver(node)
          constant_name(receiver) if receiver && constant?(receiver)
        end
      end

      sig { params(node: AST::Node).returns(T.nilable(String)) }
      def name_part_from_definition(node)
        case type_of(node)
        when CLASS, MODULE, CONSTANT_ASSIGNMENT
          module_name_from_definition(node)
        when BLOCK
          name_from_block_definition(node)
        end
      end

      sig { params(method_call_or_block_node: AST::Node).returns(T.nilable(AST::Node)) }
      def receiver(method_call_or_block_node)
        case type_of(method_call_or_block_node)
        when METHOD_CALL
          method_call_or_block_node.children[0]
        when BLOCK
          receiver(method_call_node(method_call_or_block_node))
        else
          raise TypeError
        end
      end
    end
  end

  private_constant :NodeHelpers
end
