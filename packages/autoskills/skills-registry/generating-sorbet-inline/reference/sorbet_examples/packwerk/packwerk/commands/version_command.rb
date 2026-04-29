# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class VersionCommand < BaseCommand
      extend T::Sig

      description "output packwerk version"

      sig { override.returns(T::Boolean) }
      def run
        out.puts(Packwerk::VERSION)
        true
      end
    end
  end
end
