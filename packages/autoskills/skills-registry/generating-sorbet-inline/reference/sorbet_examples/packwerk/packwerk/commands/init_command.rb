# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class InitCommand < BaseCommand
      extend T::Sig

      description "set up packwerk"

      sig { override.returns(T::Boolean) }
      def run
        out.puts("📦 Initializing Packwerk...")

        configuration_file = Generators::ConfigurationFile.generate(
          root: configuration.root_path,
          out: out
        )

        root_package = Generators::RootPackage.generate(root: configuration.root_path, out: out)

        success = configuration_file && root_package

        if success
          out.puts(<<~EOS)

            🎉 Packwerk is ready to be used. You can start defining packages and run `bin/packwerk check`.
            For more information on how to use Packwerk, see: https://github.com/Shopify/packwerk/blob/main/USAGE.md
          EOS
        else
          out.puts(<<~EOS)

            ⚠️  Packwerk is not ready to be used.
            Please check output and refer to https://github.com/Shopify/packwerk/blob/main/USAGE.md for more information.
          EOS
        end

        success
      end
    end
  end
end
