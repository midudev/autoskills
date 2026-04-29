# typed: strict
# frozen_string_literal: true

require "parser/source/map"

module Packwerk
  class Offense
    extend T::Sig
    extend T::Helpers

    sig { returns(T.nilable(Node::Location)) }
    attr_reader :location

    sig { returns(String) }
    attr_reader :file

    sig { returns(String) }
    attr_reader :message

    sig do
      params(file: String, message: String, location: T.nilable(Node::Location))
        .void
    end
    def initialize(file:, message:, location: nil)
      @location = location
      @file = file
      @message = message
    end

    sig { params(style: OutputStyle).returns(String) }
    def to_s(style = OutputStyles::Plain.new)
      location = self.location
      if location
        <<~EOS
          #{style.filename}#{file}#{style.reset}:#{location.line}:#{location.column}
          #{@message}
        EOS
      else
        <<~EOS
          #{style.filename}#{file}#{style.reset}
          #{@message}
        EOS
      end
    end
  end
end
