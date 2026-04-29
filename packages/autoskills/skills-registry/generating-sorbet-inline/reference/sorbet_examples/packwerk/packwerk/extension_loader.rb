# typed: strict
# frozen_string_literal: true

module Packwerk
  # This class handles loading extensions to packwerk using the `require` directive
  # in the `packwerk.yml` configuration.
  module ExtensionLoader
    class << self
      extend T::Sig
      sig { params(require_directive: String, config_dir_path: String).void }
      def load(require_directive, config_dir_path)
        # We want to transform the require directive to behave differently
        # if it's a specific local file being required versus a gem
        if require_directive.start_with?(".")
          require File.join(config_dir_path, require_directive)
        else
          require require_directive
        end
      end
    end
  end

  private_constant :ExtensionLoader
end
