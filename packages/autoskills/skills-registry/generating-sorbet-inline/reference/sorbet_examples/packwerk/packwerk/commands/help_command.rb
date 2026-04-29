# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class HelpCommand < BaseCommand
      extend T::Sig

      description "display help information about packwerk"

      sig { override.returns(T::Boolean) }
      def run
        err_out.puts(<<~USAGE)
          Usage: #{$PROGRAM_NAME} <subcommand>

          Subcommands:
          #{command_help_lines}
        USAGE

        true
      end

      private

      sig { returns(String) }
      def command_help_lines
        Commands.all.map do |command|
          "  #{command.name} - #{command.description}"
        end.join("\n")
      end
    end
  end
end
