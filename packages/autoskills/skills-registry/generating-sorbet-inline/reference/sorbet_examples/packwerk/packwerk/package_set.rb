# typed: strict
# frozen_string_literal: true

require "pathname"
require "bundler"

module Packwerk
  PathSpec = T.type_alias { T.any(String, T::Array[String]) }

  # A set of {Packwerk::Package}s as well as methods to parse packages from the filesystem.
  class PackageSet
    extend T::Sig
    extend T::Generic
    include Enumerable

    Elem = type_member { { fixed: Package } }

    PACKAGE_CONFIG_FILENAME = "package.yml"

    class << self
      extend T::Sig

      sig { params(root_path: String, package_pathspec: T.nilable(PathSpec)).returns(PackageSet) }
      def load_all_from(root_path, package_pathspec: nil)
        package_paths = package_paths(root_path, package_pathspec || "**")

        packages = package_paths.map do |path|
          root_relative = path.dirname.relative_path_from(root_path)
          Package.new(name: root_relative.to_s, config: YAML.load_file(path, fallback: nil))
        end

        create_root_package_if_none_in(packages)

        new(packages)
      end

      sig do
        params(
          root_path: String,
          package_pathspec: PathSpec,
          exclude_pathspec: T.nilable(PathSpec)
        ).returns(T::Array[Pathname])
      end
      def package_paths(root_path, package_pathspec, exclude_pathspec = [])
        exclude_pathspec = Array(exclude_pathspec).dup
          .push(Bundler.bundle_path.join("**").to_s)
          .map { |glob| File.expand_path(glob) }

        glob_patterns = Array(package_pathspec).map do |pathspec|
          File.join(root_path, pathspec, PACKAGE_CONFIG_FILENAME)
        end

        Dir.glob(glob_patterns)
          .map { |path| Pathname.new(path).cleanpath }
          .reject { |path| exclude_path?(exclude_pathspec, path) }
      end

      private

      sig { params(packages: T::Array[Package]).void }
      def create_root_package_if_none_in(packages)
        return if packages.any?(&:root?)

        packages << Package.new(name: Package::ROOT_PACKAGE_NAME, config: nil)
      end

      sig { params(globs: T::Array[String], path: Pathname).returns(T::Boolean) }
      def exclude_path?(globs, path)
        globs.any? do |glob|
          path.realpath.fnmatch(glob, File::FNM_EXTGLOB)
        end
      end
    end

    sig { returns(T::Hash[String, Package]) }
    attr_reader :packages

    sig { params(packages: T::Array[Package]).void }
    def initialize(packages)
      # We want to match more specific paths first
      sorted_packages = packages.sort_by { |package| -package.name.length }
      packages = sorted_packages.each_with_object({}) { |package, hash| hash[package.name] = package }
      @packages = T.let(packages, T::Hash[String, Package])
      @package_from_path = T.let({}, T::Hash[String, T.nilable(Package)])
    end

    sig { override.params(blk: T.proc.params(arg0: Package).returns(T.untyped)).returns(T.untyped) }
    def each(&blk)
      packages.values.each(&blk)
    end

    sig { params(name: String).returns(T.nilable(Package)) }
    def fetch(name)
      packages[name]
    end

    sig { params(file_path: T.any(Pathname, String)).returns(Package) }
    def package_from_path(file_path)
      path_string = file_path.to_s
      @package_from_path[path_string] ||= T.must(packages.values.find { |package| package.package_path?(path_string) })
    end
  end
end
