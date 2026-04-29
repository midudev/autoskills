# typed: strict
# frozen_string_literal: true

require "constant_resolver"
require "pathname"
require "yaml"

module Packwerk
  module Validator
    extend T::Sig
    extend T::Helpers
    extend ActiveSupport::Autoload

    autoload :Result

    abstract!

    class << self
      extend T::Sig

      sig { params(base: T::Class[T.anything]).void }
      def included(base)
        validators << base
      end

      sig { returns(T::Array[Validator]) }
      def all
        load_defaults
        T.cast(validators.map(&:new), T::Array[Validator])
      end

      private

      sig { void }
      def load_defaults
        require("packwerk/validators/dependency_validator")
      end

      sig { returns(T::Array[T::Class[T.anything]]) }
      def validators
        @validators ||= T.let([], T.nilable(T::Array[T::Class[T.anything]]))
      end
    end

    sig { abstract.returns(T::Array[String]) }
    def permitted_keys
    end

    sig { abstract.params(package_set: PackageSet, configuration: Configuration).returns(Validator::Result) }
    def call(package_set, configuration)
    end

    sig { params(configuration: Configuration, setting: T.untyped).returns(T.untyped) }
    def package_manifests_settings_for(configuration, setting)
      package_manifests(configuration).map { |f| [f, (YAML.load_file(File.join(f)) || {})[setting]] }
    end

    sig do
      params(configuration: Configuration,
        glob_pattern: T.nilable(T.any(T::Array[String], String))).returns(T::Array[String])
    end
    def package_manifests(configuration, glob_pattern = nil)
      glob_pattern ||= package_glob(configuration)
      PackageSet.package_paths(configuration.root_path, glob_pattern, configuration.exclude)
        .map { |f| File.realpath(f) }
    end

    sig { params(configuration: Configuration).returns(T.any(T::Array[String], String)) }
    def package_glob(configuration)
      configuration.package_paths
    end

    sig do
      params(
        results: T::Array[Validator::Result],
        separator: String,
        before_errors: String,
        after_errors: String,
      ).returns(Validator::Result)
    end
    def merge_results(results, separator: "\n", before_errors: "", after_errors: "")
      results.reject!(&:ok?)

      if results.empty?
        Validator::Result.new(ok: true)
      else
        Validator::Result.new(
          ok: false,
          error_value: [
            before_errors,
            separator.lstrip,
            results.map(&:error_value).join(separator),
            after_errors,
          ].join,
        )
      end
    end

    sig { params(configuration: Configuration, path: String).returns(Pathname) }
    def relative_path(configuration, path)
      Pathname.new(path).relative_path_from(configuration.root_path)
    end
  end
end
