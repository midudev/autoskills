# typed: strict
# frozen_string_literal: true

require "constant_resolver"

module Packwerk
  # Get information about unresolved constants without loading the application code.
  # Information gathered: Fully qualified name, path to file containing the definition, package,
  # and visibility (public/private to the package).
  #
  # The implementation makes a few assumptions about the code base:
  # - `Something::SomeOtherThing` is defined in a path of either `something/some_other_thing.rb` or `something.rb`,
  #   relative to the load path. Rails' `zeitwerk` autoloader makes the same assumption.
  # - It is OK to not always infer the exact file defining the constant. For example, when a constant is inherited, we
  #   have no way of inferring the file it is defined in. You could argue though that inheritance means that another
  #   constant with the same name exists in the inheriting class, and this view is sufficient for all our use cases.
  class ConstantDiscovery
    extend T::Sig

    # @param constant_resolver [ConstantResolver]
    # @param packages [Packwerk::PackageSet]
    sig do
      params(constant_resolver: ConstantResolver, packages: Packwerk::PackageSet).void
    end
    def initialize(constant_resolver:, packages:)
      @packages = packages
      @resolver = constant_resolver
    end

    # Get the package that owns a given file path.
    #
    # @param path [String] the file path
    #
    # @return [Packwerk::Package] the package that contains the given file,
    #   or nil if the path is not owned by any component
    sig do
      params(
        path: String,
      ).returns(Packwerk::Package)
    end
    def package_from_path(path)
      @packages.package_from_path(path)
    end

    # Analyze a constant via its name.
    # If the constant is unresolved, we need the current namespace path to correctly infer its full name
    #
    # @param const_name [String] The unresolved constant's name.
    # @param current_namespace_path [Array<String>] (optional) The namespace of the context in which the constant is
    #   used, e.g. ["Apps", "Models"] for `Apps::Models`. Defaults to [] which means top level.
    # @return [ConstantContext]
    sig do
      params(
        const_name: String,
        current_namespace_path: T.nilable(T::Array[String]),
      ).returns(T.nilable(ConstantContext))
    end
    def context_for(const_name, current_namespace_path: [])
      begin
        constant = @resolver.resolve(const_name, current_namespace_path: current_namespace_path)
      rescue ConstantResolver::Error => e
        raise(ConstantResolver::Error, e.message)
      end

      return unless constant

      package = @packages.package_from_path(constant.location)
      ConstantContext.new(
        constant.name,
        constant.location,
        package,
      )
    end
  end

  private_constant :ConstantDiscovery
end
