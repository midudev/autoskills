# typed: strict
# frozen_string_literal: true

module Packwerk
  module Validators
    class DependencyValidator
      extend T::Sig
      include Validator

      sig do
        override.params(package_set: PackageSet, configuration: Configuration).returns(Validator::Result)
      end
      def call(package_set, configuration)
        results = [
          check_package_manifest_syntax(configuration),
          check_acyclic_graph(package_set),
          check_valid_package_dependencies(configuration),
        ]

        merge_results(results)
      end

      sig { override.returns(T::Array[String]) }
      def permitted_keys
        [
          "enforce_dependencies",
          "dependencies",
        ]
      end

      private

      sig { params(configuration: Configuration).returns(Validator::Result) }
      def check_package_manifest_syntax(configuration)
        errors = []

        valid_settings = [true, false, "strict"]
        package_manifests_settings_for(configuration, "enforce_dependencies").each do |config, setting|
          next if setting.nil?

          unless valid_settings.include?(setting)
            errors << "\tInvalid 'enforce_dependencies' option: #{setting.inspect} in #{config.inspect}"
          end
        end

        package_manifests_settings_for(configuration, "dependencies").each do |config, setting|
          next if setting.nil?

          unless setting.is_a?(Array)
            errors << "\tInvalid 'dependencies' option: #{setting.inspect} in #{config.inspect}"
          end
        end

        if errors.empty?
          Validator::Result.new(ok: true)
        else
          merge_results(
            errors.map { |error| Validator::Result.new(ok: false, error_value: error) },
            separator: "\n",
            before_errors: "Malformed syntax in the following manifests:\n\n",
            after_errors: "\n",
          )
        end
      end

      sig { params(package_set: PackageSet).returns(Validator::Result) }
      def check_acyclic_graph(package_set)
        edges = package_set.to_h do |package|
          [
            package.name,
            package.dependencies.map { |dependency| package_set.fetch(dependency)&.name },
          ]
        end

        dependency_graph = Graph.new(edges)

        cycle_strings = build_cycle_strings(dependency_graph.cycles)

        if dependency_graph.acyclic?
          Validator::Result.new(ok: true)
        else
          Validator::Result.new(
            ok: false,
            error_value: <<~EOS
              Expected the package dependency graph to be acyclic, but it contains the following circular dependencies:

              #{cycle_strings.join("\n")}
            EOS
          )
        end
      end

      sig { params(configuration: Configuration).returns(Validator::Result) }
      def check_valid_package_dependencies(configuration)
        packages_dependencies = package_manifests_settings_for(configuration, "dependencies")
          .delete_if { |_, deps| deps.nil? }

        packages_with_invalid_dependencies =
          packages_dependencies.each_with_object([]) do |(package, dependencies), invalid_packages|
            invalid_dependencies = if dependencies.is_a?(Array)
              dependencies.filter { |path| invalid_package_path?(configuration, path) }
            else
              []
            end
            invalid_packages << [package, invalid_dependencies] if invalid_dependencies.any?
          end

        if packages_with_invalid_dependencies.empty?
          Validator::Result.new(ok: true)
        else
          error_locations = packages_with_invalid_dependencies.map do |package, invalid_dependencies|
            package ||= configuration.root_path
            package_path = Pathname.new(package).relative_path_from(configuration.root_path)
            all_invalid_dependencies = invalid_dependencies.map { |d| "  - #{d}" }

            <<~EOS
              \t#{package_path}:
              \t#{all_invalid_dependencies.join("\n\t")}
            EOS
          end

          Validator::Result.new(
            ok: false,
            error_value: "These dependencies do not point to valid packages:\n\n#{error_locations.join("\n")}"
          )
        end
      end

      sig { params(configuration: Configuration, path: T.untyped).returns(T::Boolean) }
      def invalid_package_path?(configuration, path)
        # Packages at the root can be implicitly specified as "."
        return false if path == "."

        package_path = File.join(configuration.root_path, path, PackageSet::PACKAGE_CONFIG_FILENAME)
        !File.file?(package_path)
      end

      # Convert the cycles:
      #
      #   [[a, b, c], [b, c]]
      #
      # to the string:
      #
      #   ["a -> b -> c -> a", "b -> c -> b"]
      sig { params(cycles: T.untyped).returns(T::Array[String]) }
      def build_cycle_strings(cycles)
        cycles.map do |cycle|
          cycle_strings = cycle.map(&:to_s)
          cycle_strings << cycle.first.to_s
          "\t- #{cycle_strings.join(" → ")}"
        end
      end
    end
  end
end
