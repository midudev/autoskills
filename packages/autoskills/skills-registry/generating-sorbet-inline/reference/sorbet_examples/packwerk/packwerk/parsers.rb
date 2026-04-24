# typed: strict
# frozen_string_literal: true

module Packwerk
  module Parsers
    autoload :Erb, "packwerk/parsers/erb"
    autoload :Factory, "packwerk/parsers/factory"
    autoload :ParserInterface, "packwerk/parsers/parser_interface"
    autoload :Ruby, "packwerk/parsers/ruby"

    class ParseResult < Offense; end

    class ParseError < StandardError
      extend T::Sig

      sig { returns(ParseResult) }
      attr_reader(:result)

      sig { params(result: ParseResult).void }
      def initialize(result)
        super(result.message)
        @result = result
      end
    end
  end
end
