# typed: strict
# frozen_string_literal: true

require "constant_resolver"
require "pathname"
require "yaml"

module Packwerk
  # Checks the structure of the application and its packwerk configuration to make sure we can run a check and deliver
  # correct results.
  class ApplicationValidator
    include Validator
    extend T::Sig
    extend ActiveSupport::Autoload

    autoload :Helpers

    sig { params(package_set: PackageSet, configuration: Configuration).returns(Validator::Result) }
    def check_all(package_set, configuration)
      results = Validator.all.flat_map { |validator| validator.call(package_set, configuration) }
      merge_results(results)
    end

    sig { override.params(package_set: PackageSet, configuration: Configuration).returns(Validator::Result) }
    def call(package_set, configuration)
      results = [
        check_package_manifest_syntax(configuration),
        check_application_structure(configuration),
        check_package_manifest_paths(configuration),
        check_root_package_exists(configuration),
      ]

      merge_results(results, separator: "\n❓ ")
    end

    sig { override.returns(T::Array[String]) }
    def permitted_keys
      [
        "metadata",
      ]
    end

    sig { params(configuration: Configuration).returns(Validator::Result) }
    def check_package_manifest_syntax(configuration)
      errors = []

      package_manifests(configuration).each do |manifest|
        hash = YAML.load_file(manifest)
        next unless hash

        known_keys = Validator.all.flat_map(&:permitted_keys)
        unknown_keys = hash.keys - known_keys

        unless unknown_keys.empty?
          errors << "\tUnknown keys: #{unknown_keys.inspect} in #{manifest.inspect}"
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

    sig { params(configuration: Configuration).returns(Validator::Result) }
    def check_application_structure(configuration)
      resolver = ConstantResolver.new(
        root_path: configuration.root_path.to_s,
        load_paths: configuration.load_paths,
        exclude: configuration.exclude,
      )

      begin
        resolver.file_map
        Validator::Result.new(ok: true)
      rescue => e
        Validator::Result.new(ok: false, error_value: e.message)
      end
    end

    sig { params(configuration: Configuration).returns(Validator::Result) }
    def check_package_manifest_paths(configuration)
      all_package_manifests = package_manifests(configuration, "**/")
      package_paths_package_manifests = package_manifests(configuration, package_glob(configuration))

      difference = all_package_manifests - package_paths_package_manifests

      if difference.empty?
        Validator::Result.new(ok: true)
      else
        Validator::Result.new(
          ok: false,
          error_value: <<~EOS
            Expected package paths for all package.ymls to be specified, but paths were missing for the following manifests:

            #{relative_paths(configuration, difference).join("\n")}
          EOS
        )
      end
    end

    sig { params(configuration: Configuration).returns(Validator::Result) }
    def check_root_package_exists(configuration)
      root_package_path = File.join(configuration.root_path, "package.yml")
      all_packages_manifests = package_manifests(configuration, package_glob(configuration))

      if all_packages_manifests.include?(root_package_path)
        Validator::Result.new(ok: true)
      else
        Validator::Result.new(
          ok: false,
          error_value: <<~EOS
            A root package does not exist. Create an empty `package.yml` at the root directory.
          EOS
        )
      end
    end

    private

    sig { params(list: T.untyped).returns(T.untyped) }
    def format_yaml_strings(list)
      list.sort.map { |p| "- \"#{p}\"" }.join("\n")
    end

    sig { params(configuration: Configuration, paths: T::Array[String]).returns(T::Array[Pathname]) }
    def relative_paths(configuration, paths)
      paths.map { |path| relative_path(configuration, path) }
    end
  end

  private_constant :ApplicationValidator
end
