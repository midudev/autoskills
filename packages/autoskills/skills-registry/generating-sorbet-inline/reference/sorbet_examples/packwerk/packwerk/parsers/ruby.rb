# typed: strict
# frozen_string_literal: true

require "parser"
require "prism"

module Packwerk
  module Parsers
    class Ruby
      extend T::Sig

      include ParserInterface

      class RaiseExceptionsParser < Prism::Translation::Parser
        extend T::Sig

        sig { params(builder: T.untyped).void }
        def initialize(builder)
          super(builder)
          super.diagnostics.all_errors_are_fatal = true
        end

        private

        sig { params(error: Prism::ParseError).returns(T::Boolean) }
        def valid_error?(error)
          error.type != :invalid_yield
        end
      end

      class TolerateInvalidUtf8Builder < Parser::Builders::Default
        extend T::Sig

        sig { params(token: T.untyped).returns(T.untyped) }
        def string_value(token)
          value(token)
        end
      end

      sig { params(parser_class: T.untyped).void }
      def initialize(parser_class: RaiseExceptionsParser)
        @builder = T.let(TolerateInvalidUtf8Builder.new, Object)
        @parser_class = T.let(parser_class, T.class_of(RaiseExceptionsParser))
      end

      sig { override.params(io: T.any(IO, StringIO), file_path: String).returns(T.nilable(Parser::AST::Node)) }
      def call(io:, file_path: "<unknown>")
        buffer = Parser::Source::Buffer.new(file_path)
        buffer.source = io.read
        parser = @parser_class.new(@builder)
        parser.parse(buffer)
      rescue EncodingError => e
        result = ParseResult.new(file: file_path, message: e.message)
        raise Parsers::ParseError, result
      rescue Parser::SyntaxError => e
        result = ParseResult.new(file: file_path, message: "Syntax error: #{e}")
        raise Parsers::ParseError, result
      end
    end
  end
end
