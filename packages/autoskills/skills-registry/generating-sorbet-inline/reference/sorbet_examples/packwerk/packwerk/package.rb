# typed: strict
# frozen_string_literal: true

module Packwerk
  # The basic unit of modularity for packwerk; a folder that has been declared to define a package.
  # The package contains all constants defined in files in this folder and all subfolders that are not packages
  # themselves.
  class Package
    extend T::Sig
    include Comparable

    ROOT_PACKAGE_NAME = "."

    sig { returns(String) }
    attr_reader :name

    sig { returns(T::Array[String]) }
    attr_reader :dependencies

    sig { returns(T::Hash[T.untyped, T.untyped]) }
    attr_reader :config

    sig { params(name: String, config: T.nilable(T::Hash[String, T.untyped])).void }
    def initialize(name:, config: nil)
      @name = name
      @config = T.let(config || {}, T::Hash[String, T.untyped])
      @dependencies = T.let(Array(@config["dependencies"]).freeze, T::Array[String])
      @public_path = T.let(nil, T.nilable(String))
    end

    sig { returns(T::Boolean) }
    def enforce_dependencies?
      [true, "strict"].include?(@config["enforce_dependencies"])
    end

    sig { params(package: Package).returns(T::Boolean) }
    def dependency?(package)
      @dependencies.include?(package.name)
    end

    sig { params(path: String).returns(T::Boolean) }
    def package_path?(path)
      return true if root?

      path.start_with?(@name + "/")
    end

    sig { params(other: T.untyped).returns(T.nilable(Integer)) }
    def <=>(other)
      return nil unless other.is_a?(self.class)

      name <=> other.name
    end

    sig { params(other: T.untyped).returns(T::Boolean) }
    def eql?(other)
      self == other
    end

    sig { returns(Integer) }
    def hash
      name.hash
    end

    sig { returns(String) }
    def to_s
      name
    end

    sig { returns(T::Boolean) }
    def root?
      @name == ROOT_PACKAGE_NAME
    end
  end
end
