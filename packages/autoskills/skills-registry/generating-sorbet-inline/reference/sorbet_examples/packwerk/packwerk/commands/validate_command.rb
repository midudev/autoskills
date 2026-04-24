# typed: strict
# frozen_string_literal: true

module Packwerk
  module Commands
    class ValidateCommand < BaseCommand
      extend T::Sig

      description "verify integrity of packwerk and package configuration"

      sig { override.returns(T::Boolean) }
      def run
        validator_result = T.let(nil, T.nilable(Validator::Result))

        progress_formatter.started_validation do
          validator_result = validator.check_all(package_set, configuration)
        end

        validator_result = T.must(validator_result)

        if validator_result.ok?
          out.puts("Validation successful 🎉")
        else
          out.puts("Validation failed ❗\n\n#{validator_result.error_value}")
        end

        validator_result.ok?
      end

      private

      sig { returns(ApplicationValidator) }
      def validator
        ApplicationValidator.new
      end

      sig { returns(PackageSet) }
      def package_set
        PackageSet.load_all_from(
          configuration.root_path,
          package_pathspec: configuration.package_paths
        )
      end
    end
  end
end
