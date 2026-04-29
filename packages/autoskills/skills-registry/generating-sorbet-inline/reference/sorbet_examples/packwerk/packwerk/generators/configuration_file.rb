# typed: strict
# frozen_string_literal: true

require "erb"

module Packwerk
  module Generators
    class ConfigurationFile
      extend T::Sig

      CONFIGURATION_TEMPLATE_FILE_PATH = "templates/packwerk.yml.erb"

      class << self
        extend T::Sig

        sig { params(root: String, out: T.any(IO, StringIO)).returns(T::Boolean) }
        def generate(root:, out:)
          new(root: root, out: out).generate
        end
      end

      sig { params(root: String, out: T.any(StringIO, IO)).void }
      def initialize(root:, out: $stdout)
        @root = root
        @out = out
      end

      sig { returns(T::Boolean) }
      def generate
        @out.puts("📦 Generating Packwerk configuration file...")
        default_config_path = File.join(@root, Configuration::DEFAULT_CONFIG_PATH)

        if File.exist?(default_config_path)
          @out.puts("⚠️  Packwerk configuration file already exists.")
          return true
        end

        File.write(default_config_path, render)

        @out.puts("✅ Packwerk configuration file generated in #{default_config_path}")
        true
      end

      private

      sig { returns(String) }
      def render
        ERB.new(template, trim_mode: "-").result(binding)
      end

      sig { returns(String) }
      def template
        template_file_path = File.join(__dir__, CONFIGURATION_TEMPLATE_FILE_PATH)
        File.read(template_file_path)
      end
    end
  end
end
