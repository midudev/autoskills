# typed: strict
# frozen_string_literal: true

require "ast/node"
require "better_html"
require "better_html/parser"
require "parser/source/buffer"

module Packwerk
  module Parsers
    class Erb
      extend T::Sig

      include ParserInterface

      sig { params(parser_class: T.untyped, ruby_parser: Ruby).void }
      def initialize(parser_class: BetterHtml::Parser, ruby_parser: Ruby.new)
        @parser_class = T.let(parser_class, T.class_of(BetterHtml::Parser))
        @ruby_parser = ruby_parser
      end

      sig { override.params(io: T.any(IO, StringIO), file_path: String).returns(T.untyped) }
      def call(io:, file_path: "<unknown>")
        buffer = Parser::Source::Buffer.new(file_path)
        buffer.source = io.read
        parse_buffer(buffer, file_path: file_path)
      end

      sig { params(buffer: Parser::Source::Buffer, file_path: String).returns(T.nilable(AST::Node)) }
      def parse_buffer(buffer, file_path:)
        parser = @parser_class.new(buffer, template_language: :html)
        to_ruby_ast(parser.ast, file_path)
      rescue EncodingError => e
        result = ParseResult.new(file: file_path, message: e.message)
        raise Parsers::ParseError, result
      rescue Parser::SyntaxError => e
        result = ParseResult.new(file: file_path, message: "Syntax error: #{e}")
        raise Parsers::ParseError, result
      end

      private

      sig do
        params(
          erb_ast: T.all(::AST::Node, Object),
          file_path: String
        ).returns(T.nilable(::AST::Node))
      end
      def to_ruby_ast(erb_ast, file_path)
        # Note that we're not using the source location (line/column) at the moment, but if we did
        # care about that, we'd need to tweak this to insert empty lines and spaces so that things
        # line up with the ERB file
        code_pieces = T.must(code_nodes(erb_ast)).map do |node|
          T.cast(node, ::AST::Node).children.first
        end

        @ruby_parser.call(
          io: StringIO.new(code_pieces.join("\n")),
          file_path: file_path,
        )
      end

      sig do
        params(
          node: T.any(::AST::Node, String, NilClass),
          block: T.nilable(T.proc.params(arg0: ::AST::Node).void),
        ).returns(
          T.any(T::Enumerator[::AST::Node], T::Array[String], NilClass)
        )
      end
      def code_nodes(node, &block)
        return enum_for(:code_nodes, node) unless block
        return unless node.is_a?(::AST::Node)

        yield node if node.type == :code

        # Skip descending into an ERB comment node, which may contain code nodes
        if node.type == :erb
          first_child = node.children.first
          return if first_child&.type == :indicator && first_child&.children&.first == "#"
        end

        node.children.each do |child|
          code_nodes(child, &block)
        end
      end
    end
  end
end
