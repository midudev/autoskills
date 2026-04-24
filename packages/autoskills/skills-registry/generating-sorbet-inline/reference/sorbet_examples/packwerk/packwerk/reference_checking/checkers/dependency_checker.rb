# typed: strict
# frozen_string_literal: true

module Packwerk
  module ReferenceChecking
    module Checkers
      # Checks whether a given reference conforms to the configured graph of dependencies.
      class DependencyChecker
        extend T::Sig
        include Checker

        VIOLATION_TYPE = T.let("dependency", String)

        sig { override.returns(String) }
        def violation_type
          VIOLATION_TYPE
        end

        sig do
          override
            .params(reference: Packwerk::Reference)
            .returns(T::Boolean)
        end
        def invalid_reference?(reference)
          return false unless reference.package.enforce_dependencies?
          return false if reference.package.dependency?(reference.constant.package)

          true
        end

        sig do
          override
            .params(reference: Packwerk::Reference)
            .returns(String)
        end
        def message(reference)
          const_name = reference.constant.name
          const_package = reference.constant.package
          ref_package = reference.package

          <<~EOS
            Dependency violation: #{const_name} belongs to '#{const_package}', but '#{ref_package}' does not specify a dependency on '#{const_package}'.
            Are the constant and its references in the right packages?

            #{standard_help_message(reference)}
          EOS
        end

        sig { override.params(offense: ReferenceOffense).returns(T::Boolean) }
        def strict_mode_violation?(offense)
          referencing_package = offense.reference.package
          referencing_package.config["enforce_dependencies"] == "strict"
        end

        private

        sig { params(reference: Reference).returns(String) }
        def standard_help_message(reference)
          standard_message = <<~EOS
            Inference details: this is a reference to #{reference.constant.name} which seems to be defined in #{reference.constant.location}.
            To receive help interpreting or resolving this error message, see: https://github.com/Shopify/packwerk/blob/main/TROUBLESHOOT.md#Troubleshooting-violations
          EOS

          standard_message.chomp
        end
      end
    end
  end
end
